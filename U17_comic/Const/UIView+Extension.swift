//
//  UIView+Extension.swift
//  Owner
//
//  Created by 中时通 on 2022/1/18.
//  Copyright © 2022 轻舟. All rights reserved.
//

import Foundation
import UIKit


extension UIView {
    public var z_width : CGFloat {
        get {
            return self.frame.size.width
        }
        
        set(newWidth) {
            var frame : CGRect = self.frame
            frame.size.width = newWidth
            self.frame = frame
        }
    }
    
    public var z_height : CGFloat {
        get {
            return self.frame.size.height
        }
        
        set(newHeight) {
            var frame : CGRect = self.frame
            frame.size.height = newHeight
            self.frame = frame
        }
    }
    
    public var z_size : CGSize {
        get {
            return self.frame.size
        }
        
        set(newSize) {
            var frame : CGRect = self.frame
            frame.size = newSize
            self.frame = frame
        }
    }
    
    public var z_origin : CGPoint {
        get {
            return self.frame.origin
        }
        
        set(newOrigin) {
            var frame : CGRect = self.frame
            frame.origin = newOrigin
            self.frame = frame
        }
    }
    
    public var z_centerX : CGFloat {
        get {
            return self.center.x
        }
        
        set(newCenterX) {
            var center : CGPoint = self.center
            center.x = newCenterX
            self.center = center
        }
    }
    
    public var z_centerY : CGFloat {
        get {
            return self.center.y
        }
        
        set(newCenterY) {
            var center : CGPoint = self.center
            center.y = newCenterY
            self.center = center
        }
    }
    
    public var z_left : CGFloat {
        get {
            return self.frame.origin.x
        }
        set(newLeft) {
            var frame : CGRect = self.frame
            frame.origin.x = newLeft
            self.frame = frame
        }
    }
    
    public var z_right : CGFloat {
        get {
            return self.frame.origin.x + self.frame.size.width
        }
        set(newRight) {
            var frame : CGRect = self.frame
            frame.origin.x = newRight - self.frame.size.width
            self.frame = frame
        }
    }
    
    public var z_top : CGFloat {
        get {
            return self.frame.origin.y
        }
        
        set(newTop) {
            var frame : CGRect = self.frame
            frame.origin.y = newTop
            self.frame = frame
        }
    }
    
    public var z_bottom : CGFloat {
        get {
            return self.frame.origin.y + self.frame.size.height
        }
        
        set(newBottom) {
            var frame : CGRect = self.frame
            frame.origin.y = newBottom - self.frame.size.height
            self.frame = frame
        }
    }
    
}
///设置部分圆角
extension UIView {
    /// 部分圆角
        ///
        /// - Parameters:
        ///   - corners: 需要实现为圆角的角，可传入多个
        ///   - radii: 圆角半径
    func corner(byRoundingCorners corners: UIRectCorner, radii: CGFloat) {
        
        let maskPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radii, height: radii))
                let maskLayer = CAShapeLayer()
                maskLayer.frame = self.bounds
                maskLayer.path = maskPath.cgPath
                self.layer.mask = maskLayer
    }
    
    ///使用
    ///// 调用没有任何问题，将左上角与右上角设为圆角。
//    button.corner(byRoundingCorners: [UIRectCorner.topLeft, UIRectCorner.topRight], radii: 5)
//
//    // 编译错误
//    let corners = [UIRectCorner.topLeft, UIRectCorner.topRight]
//    button.corner(byRoundingCorners: corners, radii: 5)
    
    func corner(byRoundingCorners corners: UIRectCorner, radii: CGFloat, height: CGFloat) {
        let maskPath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: screenWidth, height: height), byRoundingCorners: corners, cornerRadii: CGSize(width: radii, height: radii))
                let maskLayer = CAShapeLayer()
                maskLayer.frame = self.bounds
                maskLayer.path = maskPath.cgPath
                self.layer.mask = maskLayer
    }
    
    func corner(byRoundingCorners corners: UIRectCorner, radii: CGFloat, height: CGFloat, width: CGFloat) {
        let maskPath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: width, height: height), byRoundingCorners: corners, cornerRadii: CGSize(width: radii, height: radii))
                let maskLayer = CAShapeLayer()
                maskLayer.frame = self.bounds
                maskLayer.path = maskPath.cgPath
                self.layer.mask = maskLayer
    }
}

extension UIView {
    func setLayerColors(_ colors: [CGColor]) {
        let layer = CAGradientLayer()
        layer.frame = bounds
        layer.colors = colors
        layer.startPoint = CGPoint(x: 0, y: 0)
        layer.endPoint = CGPoint(x: 1, y: 0)
        self.layer.addSublayer(layer)
    }
}
