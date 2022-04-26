//
//  UpdateModel.swift
//  U17_comic
//
//  Created by qingzhou on 2022/4/14.
//

import UIKit
import HandyJSON


struct UpdateModel: HandyJSON {

     var page: String = ""
     var curDay: String = ""
     var hasMore: String = ""
     var isNew: String = ""
     var comics: [InfoModel] = []
    
}

struct InfoModel: HandyJSON {
     var chapterIndex: String = ""
     var comic_sort: String = ""
     var uiType: String = ""
     var comicId: String = ""
     var is_dynamic_img: String = ""
     var cover: String = ""
     var title: String = ""
     var btnColor: String = ""
     var publish_time: String = ""
    
     var tagList: [tagModel] = []
    
     var description: String = ""
     var actionType: String = ""
     var comicName: String = ""
     var chapterId: String = ""
     var comicType: String = ""
     var todayId: String = ""
}

struct tagModel: HandyJSON {
     var tagColor: String = ""
     var tagStr: String = ""
}
