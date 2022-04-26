//
//  QZHeader.swift
//  Owner
//
//  Created by 中时通 on 2022/1/18.
//  Copyright © 2022 轻舟. All rights reserved.
//

import UIKit

import Kingfisher

let screenWidth : CGFloat = UIScreen.main.bounds.width
let screenHeight : CGFloat = UIScreen.main.bounds.height

/// 宽度比
let kScalWidth = (screenWidth / 375)
/// 高度比
let kScalHeight = (screenHeight / 667)

let safeBottom = (SystemUtils.getIsIphoneX() ? 20:0)

let placeholder = UIImage(named: "commondefaultImage")
