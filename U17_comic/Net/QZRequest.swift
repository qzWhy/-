//
//  QZRequest.swift
//  dctt_qz
//
//  Created by qingzhou on 2022/4/13.
//

import Foundation
import Alamofire
import Moya

public enum QZRequestType {

    case requestData
    
    case downloadData(DownloadRequest.Destination)
    
    case uploadData
}

struct QZRequest : TargetType, MoyaAddable {
    
    var parameters : [String : Any] = [:]
    
    var path: String
    
    var method: Moya.Method
    
    var requestType: QZRequestType = .requestData
    
    var task: Task {
        switch requestType {
        case .requestData:
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case .downloadData(let dest):
            return .downloadDestination(dest)
        default:
            return .requestPlain
        }
    }
    
    var cacheKey: String?
    
    var isShowHud: Bool
    var isShowError: Bool
    var isAnalysis: Bool
    
    
    
    init(destination: @escaping DownloadRequest.Destination, url: String, isShow: Bool = false, isShowErr: Bool = true, isAnaly: Bool = true, apiMethod: Moya.Method = .get) {
        requestType = .downloadData(destination)
        path = url
        cacheKey = "ok"
        isShowHud = isShow
        isShowError = isShowErr
        isAnalysis = isAnaly
        method = apiMethod
    }
    
    init(params: [String : Any]?, url: String, isShow: Bool = false, isShowErr: Bool = true, isAnaly: Bool = true, apiMethod: Moya.Method = .get) {
        
        if let p = params {
            parameters = p
        }
        parameters["device_id"] = "69EACCA0-47C8-40EE-835F-7C02D8105F93"
        parameters["model"] = "iPhone%207%20Plus"
        parameters["systemVersion"] = "13.3.1"
        parameters["target"] = "U17_3.0"
        parameters["time"] = SystemUtils.getCurrentSecTime()
        parameters["version"] = "5.8.0"
        path = url
        cacheKey = "ok"
        isShowHud = isShow
        isShowError = isShowErr
        isAnalysis = isAnaly
        method = apiMethod
    }

}

//extension QZRequest: ParameterEncoding {
//
//    func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
//        var urlRequest = try urlRequest.asURLRequest()
//        guard let parameters = parameters else { return urlRequest }
//        do {
//            let data = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
//
//            let str = String.init(data: data, encoding: String.Encoding.utf8)
//            let body = str?.data(using: String.Encoding.utf8)
//            let string = body?.base64EncodedString(options: Data.Base64EncodingOptions.endLineWithLineFeed)
//            let bodybase64 = string?.data(using: String.Encoding.utf8)
//            urlRequest.httpBody = bodybase64
//        } catch {
//            throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
//        }
//
//        return urlRequest
//    }
//}

