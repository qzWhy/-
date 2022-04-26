//
//  QZNetWorkManager.swift
//  dctt_qz
//
//  Created by qingzhou on 2022/4/13.
//

import UIKit
import Moya
import HandyJSON

protocol MoyaAddable {
    
    var cacheKey : String? { get }
    var isShowHud : Bool { get }
    var isShowError : Bool { get }
    var isAnalysis : Bool { get }
}

public extension TargetType {
    
    var baseURL : URL {
        return URL(string: BaseIP)!
    }
    
    var headers : [String : String]? {
        
        let dictionary : [String : String] = [
                                                "Content-Type" : "application/json; charset=utf-8"
                                              ]
//        if ZXLogin.isLogin() {
//            dictionary["x-requested-custom-token"] = ZXLogin.getZSTCookie()
//        }
        return dictionary
    }
    
    var sampleData : Data {
        return Data()
    }
    
}

class QZNetWorkManager {
    @discardableResult
    func request(
        method : Moya.Method = .get,
        path : String,
        params : Dictionary<String, Any>?,
        isShowHud : Bool = true,
        isShowError : Bool = true,
        isAnalysis : Bool = true,
        successBlock : @escaping ((QZResponse) -> ()),
        errorBlock : @escaping (QZError) -> ()) -> Cancellable?
    {
        let request : QZRequest = QZRequest.init(params: params, url: path, isShow: isShowHud, isShowErr: isShowError, isAnaly: isAnalysis, apiMethod: method)
        
        return self.request(request, successBlock: successBlock, errorBlock: errorBlock)
    }
    
    @discardableResult
    func download(
        destination: @escaping DownloadDestination,
        path: String, 
        isShowHud: Bool = true,
        isShowError: Bool = true,
        successBlock: @escaping ((QZResponse) -> ()),
        errorBlock : @escaping (QZError) ->()
    ) -> Cancellable? {
        let request : QZRequest = QZRequest.init(destination: destination, url: path, isShow: isShowHud, isShowErr: isShowError)
        return self.request(request, successBlock: successBlock, errorBlock: errorBlock)
    }
    
    @discardableResult
    func request<R : TargetType & MoyaAddable>(
        _ type : R,
        progressBlock : ((Double) -> ())? = nil,
        successBlock : @escaping ((QZResponse) -> ()),
        errorBlock : @escaping (QZError) -> ()) -> Cancellable?
    {
        if isSameRequest(type) {
            return nil
        }
        
        let provider : MoyaProvider = createProvider(type: type)
        
        let cancellable : Cancellable? = provider.request(type, callbackQueue: DispatchQueue.global()) { progress in
            
        } completion: { result in
            
            self.cleanRequest(type)
            
            let insideErrorblock = { (error: QZError) in
                DispatchQueue.main.async {
                    if type.isShowError {
                        if let message = error.message, message.count > 0 {
                            debugPrint(message)
//                            MPAlertView.show(message)
                        }else{
                            debugPrint(error.code)
//                            MPAlertView.show(CodetoMsg.codetoMsg(error.code))
                        }
                    }
                    errorBlock(error)
                }
            }
            let insideSuccessblock = { (response: QZResponse) in
                DispatchQueue.main.async {
                    successBlock(response)
                }
            }
            switch result {
            case .success(let successResponse):
                do {
                    let successResponse = try self.handleSuccessResponse(type, response: successResponse)
                    if let success = successResponse {
                        insideSuccessblock(success)
                    } else {
                        insideErrorblock(QZError.serverResponse(message: "请求失败", code: "0"))
                    }
                } catch {
                    debugPrint("")
                }
                
            case .failure(let error):
                var errorString = "网络不好"
                if let errorDescription = error.errorDescription {
                    errorString = errorDescription
                }
                insideErrorblock(QZError.exception(message: errorString))
            }
        }

        return cancellable
    }
    
    // 用来处理只请求一次的栅栏队列
    private let barrierQueue = DispatchQueue(label: "cn.tsingho.qingyun.NetworkManager", attributes: .concurrent)
    // 用来处理只请求一次的数组,保存请求的信息 唯一
    private var fetchRequestKeys = [String]()
}

extension QZNetWorkManager {
    //创建Moya请求类
    private func createProvider<T: TargetType & MoyaAddable>(type: T) -> MoyaProvider<T> {
        let activityPlugin = NetworkActivityPlugin { (state, targetType) in
            switch state {
            case .began:
                DispatchQueue.main.async {
                    if type.isShowHud {
                        print("开始加载")
//                    SVProgressHUD.showLoading()
                    }
                    self.startStatusNetworkActivity()
                }
            case .ended:
                DispatchQueue.main.async {
                    if type.isShowHud {
                        print("结束加载")
//                    SVProgressHUD.dismiss()
                        
                    }
                    self.stopStatusNetworkActivity()
                }
            }
        }
        let provider = MoyaProvider<T>(plugins: [activityPlugin])
        return provider
    }
    
    //处理成功的返回
    private func handleSuccessResponse<R : TargetType & MoyaAddable>(
        _ type: R,
        response: Response) throws -> QZResponse? {
            switch type.task {
            case .requestData, .requestParameters, .uploadMultipart:
                if response.data.count == 0 {
                    let z_response : QZResponse? = QZResponse.init(data: [:])
                    return z_response!
                }
                var z_response :QZResponse?
                if type.isAnalysis {
                    guard let json = try? JSONSerialization.jsonObject(with: response.data, options: JSONSerialization.ReadingOptions.mutableContainers) else {
                        throw QZError.jsonSerializationFailed(message: "网络请求失败！！")
                    }
                    z_response = QZResponse.init(data: (NSObject.checkNull(obj: json) as! Dictionary<String, Any>))
                }else{
                    debugPrint("response---\(response)")
                    z_response = QZResponse.init(data: ["success": true])
                }
                z_response?.objAny = response.data
                
                guard let res = z_response else {
                    throw QZError.jsonToDictionaryFailed(message: "网络请求失败！！")
                }
                return res
                if res.success {
                    return res
                } else if res.code == "100003" || res.code == "100005" {
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "loginouttime"), object: nil)
                    throw QZError.loginStateIsexpired(message: res.message, code: res.code)
                }else {
                    throw QZError.serverResponse(message: res.message, code: res.code)
                }
                
            default:
                return nil
            }
        }
    
    private func startStatusNetworkActivity() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    private func stopStatusNetworkActivity() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    private func isSameRequest<R: TargetType & MoyaAddable>(_ type: R) -> Bool {
        switch type.task {
        case let .requestParameters(parameters, _):
            let key = type.path + parameters.description
            var result: Bool!
            barrierQueue.sync(flags: .barrier) {
                result = fetchRequestKeys.contains(key)
                if !result {
                    fetchRequestKeys.append(key)
                }
            }
            return result
        default:
            // 不会调用
            return false
        }
    }
    
    private func cleanRequest<R: TargetType & MoyaAddable>(_ type: R) {
        switch type.task {
        case let .requestParameters(parameters, _):
            let key = type.path + parameters.description
            barrierQueue.sync(flags: .barrier) {
                fetchRequestKeys.remove(key)
            }
        default:
            // 不会调用
            ()
        }
    }
}

