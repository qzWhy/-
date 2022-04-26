//
//  ComicIntroModel.swift
//  U17_comic
//
//  Created by qingzhou on 2022/4/19.
//

import UIKit
import HandyJSON

struct ComicIntroModel: HandyJSON {

    var chapter_list:[chapterModel]?
    var otherWorks:[otherWorkModel]?
    var comment: commentModel?
    var comic: comicModel1?
    var tongRenCover: String?
    var showPageName: String?
}

struct chapterModel: HandyJSON {
    var name:String?
    var image_total:String?
    var chapter_id:String?
    var size:String?
    var zip_high_webp:String?
    var crop_zip_size: String?
    var vip_images:String?
    var is_view:String?
    var buyed:String?
    var publish_time:String?
    var chapterIndex:String?
    var countImHightArr:String?
    var buy_price:String?
    var free_image_num:String?
    var read_state:String?
    var is_free:String?
}
struct otherWorkModel: HandyJSON {
    var comicId: String?
    var coverUrl: String?
    var name:String?
    var passChapterNum: String?
}

struct commentModel: HandyJSON {
    var commentList:[commentListModel]?
    var commentCount: String?
}
struct commentListModel: HandyJSON {
    var comment_id:String?
    var user_id: String?
    var content: String?
    var create_time: String?
    var floor: String?
    var is_delete: String?
    var is_up: String?
    var thread_id: String?
    var total_reply: String?
    var is_choice: String?
    var praise_total: String?
    var ticket_id: String?
    var cate: String?
    var object_type: String?
    var content_filter: String?
    var ticketNum: String?
    var gift_num: String?
    var gift_img: String?
    var user: userModel?
    var imageList:[String]?
    var comic_id: String?
    var create_time_str: String?
}
struct userModel: HandyJSON {
    var face: String?
    var nickname: String?
    var group_user: String?
    var is_author: String?
    var other_comic_author: String?
    var vip_level: String?
    var user_title: String?
    var grade: String?
}

struct comicModel1: HandyJSON {
    var name: String?
    var short_description: String?
    var accredit: String?
    var type: String?
    var description: String?
    var cate_id: String?
    var thread_id: String?
    var series_status: String?
    var last_update_time: String?
    var week_more: String?
    var affiche: String?
    var month_gift: String?
    var last_update_week: String?
    var cover: String?
    var ori: String?
    var wideCover: String?
    var theme_ids:[String]?
    var classifyTags:[classifyTag]?
    var chargeChapterNum: String?
    var author: authorModel?
    var share: shareModel?
    var wideColor: String?
    var tagList:[String]?
    var comic_id: String?
    var is_vip: String?
    var status: String?
    var user_id: String?
    var click_total: String?
    var favorite_total: String?
    var total_ticket: String?
    var monthly_ticket: String?
    var month_ticket: String?
    var total_tucao: String?
    var gift_total:String?
    var pass_chapter_num: String?
    var vip_discount: String?
    var year_vip_discount: String?
    var comment_total: String?
    var is_free: String?
    var is_vip_free: String?
    var is_vip_buy: String?
    var is_buy_action: String?
    var is_auto_buy: String?
    var ticket_desc: String?
}

struct classifyTag: HandyJSON {
    var name: String?
    var argName: String?
    var argVal: String?
}

struct authorModel: HandyJSON {
    var avatar: String?
    var name: String?
    var id: String?
}
struct shareModel: HandyJSON {
    var title: String?
    var content: String?
    var cover: String?
    var posterCovers:[String]?
    var url: String?
}
