//
//  HModel.swift
//  dctt_qz
//
//  Created by qingzhou on 2022/4/11.
//

import UIKit
import HandyJSON

struct HModel: HandyJSON {
     var praiseCnt: String? = nil
     var images: String? = nil
     var imageNum: String? = nil
    
     var uid: String? = nil
     var user: QUser? = nil
    
    
     var postDate: String? = nil
     var type: String? = nil
     var status: String? = nil
     var content: String? = nil
     var readCnt: String? = nil
     var pid: String? = nil
}

struct QTitleModel : HandyJSON {
    var title: String? = nil
    var type: String? = nil
    var tag: String? = nil
    var search_hot: String? = nil
    var id: String? = nil
    var banner_id: String? = nil
    var is_recommend: String? = nil
    var url: String? = nil
}

extension Array: HandyJSON{}

struct QTitleList: HandyJSON {
    var  returnData: [QTitleModel]?
}

struct ReturnData<T : HandyJSON>: HandyJSON {
    var message:String?
    var returnData: T?
    var stateCode: Int = 0
}

struct ResponseData<T : HandyJSON>: HandyJSON {
    var code : Int = 0
    var message: String?
    var data: ReturnData<T>?
}
