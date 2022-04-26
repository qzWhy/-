//
//  UIButton+Extension.swift
//  zhongshitong
//
//  Created by zst on 2021/8/6.
//  Copyright © 2021 jusa. All rights reserved.
//

import Foundation
import UIKit

enum ZXButtonEdgeInsetsStyle {
    case styleTop
    case styleLeft
    case styleBottom
    case styleRight
}

extension UIButton {
    
    func layoutButtonWithEdgeInsetsStyle(_ style: ZXButtonEdgeInsetsStyle, _ space: CGFloat) {
        // 1. 得到imageView和titleLabel的宽、高
        let imageWith: CGFloat = self.imageView?.frame.size.width ?? 0.0
        let imageHeight: CGFloat = self.imageView?.frame.size.height ?? 0.0
         
        var labelWidth: CGFloat = 0.0
        var labelHeight: CGFloat = 0.0

        if #available(iOS 8.0, *) {
            labelWidth = self.titleLabel?.intrinsicContentSize.width ?? 0.0
            labelHeight = self.titleLabel?.intrinsicContentSize.height ?? 0.0
        }else{
            labelWidth = self.titleLabel?.frame.size.width ?? 0.0
            labelHeight = self.titleLabel?.frame.size.height ?? 0.0
        }
         
        // 2. 声明全局的imageEdgeInsets和labelEdgeInsets
        var imageEdgeInsets: UIEdgeInsets = UIEdgeInsets.zero;
        var labelEdgeInsets: UIEdgeInsets = UIEdgeInsets.zero;

        // 3. 根据style和space得到imageEdgeInsets和labelEdgeInsets的值
        switch style {
        case .styleTop:
            imageEdgeInsets = UIEdgeInsets.init(top: -labelHeight-space/2.0, left: 0, bottom: 0, right: -labelWidth)
            labelEdgeInsets = UIEdgeInsets.init(top: 0, left: -imageWith, bottom: -imageHeight-space/2.0, right: 0)
        case .styleLeft:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: -space/2.0, bottom: 0, right: space/2.0);
            labelEdgeInsets = UIEdgeInsets(top: 0, left: space/2.0, bottom: 0, right: -space/2.0);
        case .styleBottom:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: -labelHeight-space/2.0, right: -labelWidth);
            labelEdgeInsets = UIEdgeInsets(top: -imageHeight-space/2.0, left: -imageWith, bottom: 0, right: 0);
        case .styleRight:
            imageEdgeInsets = UIEdgeInsets(top: 0, left: labelWidth+space/2.0, bottom: 0, right: -labelWidth-space/2.0);
            labelEdgeInsets = UIEdgeInsets(top: 0, left: -imageWith-space/2.0, bottom: 0, right: imageWith+space/2.0);
        }

        // 4. 赋值
        self.titleEdgeInsets = labelEdgeInsets;
        self.imageEdgeInsets = imageEdgeInsets;
    }
    
//    open override var intrinsicContentSize: CGSize {
//        let intrinsicContentSize = super.intrinsicContentSize
//        let adjustedWidth = intrinsicContentSize.width + titleEdgeInsets.left + titleEdgeInsets.right
//              let adjustedHeight = intrinsicContentSize.height + titleEdgeInsets.top + titleEdgeInsets.bottom
//
//              return CGSize(width: adjustedWidth, height: adjustedHeight)
//
//    }
}
