//
//  ComicModel.swift
//  U17_comic
//
//  Created by qingzhou on 2022/4/15.
//

import UIKit
import HandyJSON

struct ComicModel: HandyJSON {

    var galleryItems:[galleryItemModel]?
    var textItems: [Any]?
    var modules:[moduleModel]?
    var editTime: String?
    var defaultSearch: String?
    var curTime: String?
    var showPageName: String?
}

struct galleryItemModel: HandyJSON {
    var linkType: String?
    var cover: String?
    var id: String?
    var title: String?
    var content: String?
    var user_reg_time: String?
    var show_day: String?
    var main_color: String?
    var topCover: String?
    var ext: [extModel]?
}

struct extModel: HandyJSON {
    var key: String?
    var val: String?
}

struct moduleModel: HandyJSON {
    var moduleType: String?
    var uiType: String?
    var moduleInfo:moduleInfo?
    var items:Any?
}

struct moduleInfo: HandyJSON {
    var argName: String?
    var argValue: String?
    var title: String?
    var icon: String?
    var bgCover: String?
}

struct itemModel: HandyJSON {
    var comicId:String?
    var title: String?
    var cover: String?
    var subTitle: String?
    var color: String?
    var wideCover:String?
}

struct itemModel1: HandyJSON {
    var linkType: String?
    var cover: String?
    var id: String?
    var title: String?
    var content: String?
    var user_reg_time: String?
    var show_day: String?
    var main_color: String?
    var ext: [extModel]?
}

