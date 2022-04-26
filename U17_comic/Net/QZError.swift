//
//  QZError.swift
//  dctt_qz
//
//  Created by qingzhou on 2022/4/13.
//

import Foundation


// 网络错误处理枚举
public enum QZError: Error  {
    // json解析失败
    case jsonSerializationFailed(message: String)
    // json转字典失败
    case jsonToDictionaryFailed(message: String)
    
    // 登录状态变化
    case loginStateIsexpired(message: String?, code : String)
    // 服务器返回的错误
    case serverResponse(message: String?, code: String)
    
    // 自定义错误
    case exception(message: String)
}

extension QZError {
    
    var message: String? {
        switch self {
        case let .serverResponse(msg, _):
            return msg
        case let .exception(msg):
            return msg
        case let .loginStateIsexpired(msg, _):
            return msg
        case let .jsonToDictionaryFailed(msg):
            return msg
        case let .jsonSerializationFailed(msg):
            return msg
        }
    }
    
    var code: String {
        switch self {
        case let .serverResponse(_, code):
            return code
        case let .loginStateIsexpired(_, code):
//            LoginAction.loginExpired()
            return code
        default:
            return "-1"
        }
    }
}

