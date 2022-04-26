//
//  NetManager.swift
//  dctt_qz
//
//  Created by qingzhou on 2022/4/12.
//

import Moya
import MBProgressHUD
import HandyJSON
import Result
import CWLog

//MARK: loading插件，组合API请求，可在请求中自动补充loading
let LoadingPlugin = NetworkActivityPlugin { (type, target) in
//    guard let vc = topVC else {return}
    switch type {
    case .began: break
//        MBProgressHUD.hide(for: vc.view, animated: false)
//        MBProgressHUD.showAdded(to: vc.view, animated: true)
    case .ended: break
//        MBProgressHUD.hide(for: vc.view, animated: true)
    }
    
}

//MARK: 超时中间件
let timeoutClosure = {(endpoint: Endpoint, closure: MoyaProvider<NetManager>.RequestResultClosure) -> Void in
    
    if var urlRequest = try? endpoint.urlRequest() {
        urlRequest.timeoutInterval = 20
        closure(.success(urlRequest))
    } else {
        closure(.failure(MoyaError.requestMapping(endpoint.url)))
    }
}

//MARK: 无loading请求
let ApiProvider = MoyaProvider<NetManager>(requestClosure: timeoutClosure)
//MARK: 有loading请求
let ApiLoadingProvider = MoyaProvider<NetManager>(requestClosure: timeoutClosure, plugins: [LoadingPlugin])


enum NetManager {
    /**获取segment**/
    case Recommend(device_id: String, model: String,sTime: String,systemVersion: String, target: String, time: String, version: String)
    //搜索热门
    case searchHot
   /**漫画**/
    case comic(device_id: String, model: String,systemVersion: String, target: String, time: String, version: String)
    /**更新**/
    case todayRecommend(android_id:String, day: Int,device_id: String ,model: String,page: Int, systemVersion: String, target: String, time: String, version: String)
    /**每日领奖**/
    case signInPage
    /**热血及其他**/
    case recommendItem(device_id: String, display_pos: String, model: String,
        systemVersion: String, target: String, time: String, version: String)
    case detail_simple_dynamic(comic: String, device_id: String, model: String)
    case chapterNewBatch(chapter_id: String)
}

extension NetManager: TargetType {
    var path: String {
        switch self {
        case .Recommend:
            return "/Recommend/head"
        case .searchHot:
            return "/search/hotkeywordsnew"
        case .comic:
            return "/comic/getDetectListV4_5"
        case .todayRecommend:
            return "/list/todayRecommendList"
        case .signInPage:
            return ""
        case .recommendItem:
            return "/Recommend/item"
        case .detail_simple_dynamic:
            return "/comic/detail_simple_dynamic"
        case .chapterNewBatch:
            return "/comic/chapterNewBatch"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Task {
        var paramters: [String : Any] = [:]
        paramters["device_id"] = "69EACCA0-47C8-40EE-835F-7C02D8105F93"
        paramters["model"] = "iPhone%207%20Plus"
        paramters["systemVersion"] = "13.3.1"
        paramters["target"] = "U17_3.0"
        paramters["time"] = SystemUtils.getCurrentSecTime()
        paramters["version"] = "5.8.0"
        switch self {
        case .Recommend(let device_id, let model, let sTime, let systemVersion, let target, let time, let version):
//            paramters["device_id"] = device_id
//            paramters["model"] = model
            paramters["sTime"] = sTime
//            paramters["systemVersion"] = systemVersion
//            paramters["target"] = target
//            paramters["time"] = time
//            paramters["version"] = version
            break
        case .todayRecommend(let android_id, let day, let device_id, let model, let page, let systemVersion, let target, let time, let version):
            paramters["android_id"] = android_id
//            paramters["model"] = model
//            paramters["device_id"] = device_id
            paramters["page"] = page
            paramters["day"] = day
//            paramters["systemVersion"] = systemVersion
//            paramters["target"] = target
//            paramters["time"] = time
//            paramters["version"] = version
            break
        case .recommendItem(device_id: let device_id, display_pos: let dis, model: let model, systemVersion: let sys, target: let target, time: let time, version: let version):
            paramters["display_pos"] = dis
//            paramters["model"] = model
//            paramters["device_id"] = device_id
//            paramters["systemVersion"] = sys
//            paramters["target"] = target
//            paramters["time"] = time
//            paramters["version"] = version
        case .chapterNewBatch(chapter_id: let chapter_id):
            paramters["chapter_id"] = chapter_id
        default:break
        }
        return .requestParameters(parameters: paramters, encoding: URLEncoding.default)
    }
    
    var sampleData: Data { return "".data(using: String.Encoding.utf8)! }
    
    var headers: [String : String]? {
        return nil
    }
    
    var baseURL: URL {
        return URL(string: "https://app.u17.com/v3/appV3_3/ios/phone")!
    }
    
}

//MARK: 请求结果解析模型
extension Response {
    func mapModel<T: HandyJSON>(_ type: T.Type)throws -> T {
        let jsonString = String(data: data, encoding: .utf8)
        CWLog(jsonString)
        guard let model = JSONDeserializer<T>.deserializeFrom(json: jsonString) else {
            throw MoyaError.jsonMapping(self)
        }
        return model
    }
}

//MARK: 统一请求封装
extension MoyaProvider {
    @discardableResult
    open func request<T: HandyJSON>(_ target: Target,
                                    model: T.Type,
                                    completion:((_ returnData: T?) -> Void)?
    ) -> Cancellable? {
        return request(target) { result in
            debugPrint(result.value)
            guard let completion = completion else {
                return
            }

            guard let returnData = try? result.value?.mapModel(ResponseData<T>.self) else {
                completion(nil)
                return
            }
            completion(returnData.data?.returnData)
        }
    }
    
}

