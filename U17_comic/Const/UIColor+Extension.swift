//
//  UIColor+Extension.swift
//  Owner
//
//  Created by 中时通 on 2022/1/18.
//  Copyright © 2022 轻舟. All rights reserved.
//

import Foundation
import UIKit


extension UIColor {
    
    static func random() -> UIColor {
        return UIColor.colorRGB(r: CGFloat(arc4random_uniform(256)), g: CGFloat(arc4random_uniform(256)), b: CGFloat(arc4random_uniform(256)))
    }
    
    static func colorWithHexString(hexString : String?) -> UIColor {
        guard let tempStr = hexString else {
            return UIColor.black
        }
        
        if tempStr.count < 6 {
            return UIColor.black
        }
        var tempHex : String = tempStr.uppercased()
        if tempHex.hasPrefix("0x") || tempHex.hasPrefix("##") || tempHex.hasPrefix("0X") {
            tempHex = String(tempHex.dropFirst(2))
        }
        if tempHex.hasPrefix("#") {
            tempHex = String(tempHex.dropFirst())
        }
        var range = NSRange(location: 0, length: 2)
        let rHex = (tempHex as NSString).substring(with: range)
        range.location = 2
        let gHex = (tempHex as NSString).substring(with: range)
        range.location = 4
        let bHex = (tempHex as NSString).substring(with: range)
        var r : UInt32 = 0, g : UInt32 = 0, b : UInt32 = 0
        Scanner(string: rHex).scanHexInt32(&r)
        Scanner(string: gHex).scanHexInt32(&g)
        Scanner(string: bHex).scanHexInt32(&b)
        
        return self.colorRGB(r: CGFloat(r), g: CGFloat(g), b: CGFloat(b))
    }
    
    static func colorWithHexString(hexString : String?, alpha: CGFloat) -> UIColor {
        guard let tempStr = hexString else {
            return UIColor.black
        }
        
        if tempStr.count < 6 {
            return UIColor.black
        }
        var tempHex : String = tempStr.uppercased()
        if tempHex.hasPrefix("0x") || tempHex.hasPrefix("##") || tempHex.hasPrefix("0X") {
            tempHex = String(tempHex.dropFirst(2))
        }
        if tempHex.hasPrefix("#") {
            tempHex = String(tempHex.dropFirst())
        }
        var range = NSRange(location: 0, length: 2)
        let rHex = (tempHex as NSString).substring(with: range)
        range.location = 2
        let gHex = (tempHex as NSString).substring(with: range)
        range.location = 4
        let bHex = (tempHex as NSString).substring(with: range)
        var r : UInt32 = 0, g : UInt32 = 0, b : UInt32 = 0
        Scanner(string: rHex).scanHexInt32(&r)
        Scanner(string: gHex).scanHexInt32(&g)
        Scanner(string: bHex).scanHexInt32(&b)
        
        return self.colorRGBA(r: CGFloat(r), g: CGFloat(g), b: CGFloat(b), a: alpha)
    }
    
    /// Convert String-type hex color codes into UIColor.
    static func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    static func colorWithRGBHex(hex : UInt32) -> UIColor {
        let r : CGFloat = CGFloat((hex >> 16) & 0xFF)
        let g : CGFloat = CGFloat((hex >> 8) & 0xFF)
        let b : CGFloat = CGFloat((hex) & 0xFF)
        return UIColor.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1.0)
    }
    
    static func colorRGB(r : CGFloat, g : CGFloat, b : CGFloat) -> UIColor {
        return UIColor.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1.0)
    }
    
     static func colorRGBA(r : CGFloat, g : CGFloat, b : CGFloat, a : CGFloat) -> UIColor {
        return UIColor.init(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
    }
}
