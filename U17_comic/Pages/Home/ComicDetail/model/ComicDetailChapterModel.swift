//
//  ComicDetailChapterModel.swift
//  U17_comic
//
//  Created by qingzhou on 2022/4/24.
//

import UIKit
import HandyJSON

struct ComicDetailChapterModel: HandyJSON {

    var status: String?
    var chapter_id: String?
    var type: String?
    var image_list:[imgModel]?
    var stateCode: String?
    var message: String?
}

struct imgModel: HandyJSON {
    var id: String?
    var sort: String?
    var location: String?
    var image_id: String?
    var width: Double?
    var height: Double?
    var total_tucao: String?
    var webp: String?
    var type: String?
    var img05: String?
    var img50: String?
    var images:[imgModel]?
    
}

