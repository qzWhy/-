//
//  QZBaseResponse.swift
//  dctt_qz
//
//  Created by qingzhou on 2022/4/13.
//

import UIKit
import SwiftyJSON

class QZBaseResponse {
    var json : [String : Any]
    /// 请求成功与否
    var success : Bool {
        guard let temp = json["success"] as? Bool else {
            return false
        }
        return temp
    }
    
    /// 状态码
    var code : String {
        guard let temp = json["code"] as? String else {
            return "-1"
        }
        return temp
    }
    
    /// 当前时间
    var currenttime : String? {
        guard let temp = json["currenttime"] as? String else {
            return nil
        }
        return temp
    }
    
    /// 提示信息
    var message : String? {
        guard let temp = json["msg"] as? String else {
            return nil
        }
        return temp
    }
    
    var obj : JSON? {
        guard let temp = json["obj"] else {
            return nil
        }
        let tempObj = JSON.init(temp)
        return tempObj
    }
    
    var objAny : Any?
    
    init?(data : Dictionary<String, Any>?) {
        guard let temp = data else {
            return nil
        }
        self.json = temp
    }
}



class QZResponse: QZBaseResponse {
    var data: Dictionary<String, Any>? {
        return self.json
    }
}


