//
//  BaseModel.swift
//  Owner
//
//  Created by 中时通 on 2022/2/11.
//  Copyright © 2022 轻舟. All rights reserved.
//

import UIKit

class BaseModel: NSObject {
    var title: String = ""
    var isSelect:Bool = false
    var image:String = ""
    
    
    init(title: String) {
        super.init()
        self.title = title
        self.isSelect = false
        self.image = ""
    }
}
