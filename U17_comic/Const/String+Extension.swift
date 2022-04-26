//
//  NSString+Extension.swift
//  zhongshitong
//
//  Created by zst on 2019/4/20.
//  Copyright © 2019 jusa. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    /// 解析base64，返回Data类型
    func dataWithBase64EncodedString() -> Data? {
        if self.count <= 0 {
            return nil
        }
        let decoded : Data? = Data.init(base64Encoded: self, options: Data.Base64DecodingOptions(rawValue: 1))
        return decoded
    }
    
    /// 解析base64，返回String类型
    func stringWithBase64EncodedString() -> String?{
        let data : Data? = self.dataWithBase64EncodedString()
        if data != nil {
            return String.init(data: data!, encoding: String.Encoding.utf8)
        }else{
            return nil
        }
    }

    /// 把base64转化成字符串
    func base64EncodedStringWithWrapWidth(wrapWidth : Int) -> String? {
        let data : Data? = self.data(using: String.Encoding.utf8, allowLossyConversion: true)
       return data?.base64EncodedStringWithWrapWidth(wrapWidth: wrapWidth)
    }
    
    func toNSRange(_ range: Range<String.Index>) -> NSRange {
        guard let from = range.lowerBound.samePosition(in: utf16), let to = range.upperBound.samePosition(in: utf16) else {
            return NSMakeRange(0, 0)
        }
        return NSMakeRange(utf16.distance(from: utf16.startIndex, to: from), utf16.distance(from: from, to: to))
    }
    
    /// NSRange转化为range
    func toRange(from nsRange: NSRange) -> Range<String.Index>? {
        guard let from16 = utf16.index(utf16.startIndex, offsetBy: nsRange.location, limitedBy: utf16.endIndex),
            let to16 = utf16.index(from16, offsetBy: nsRange.length, limitedBy: utf16.endIndex),
            let from = String.Index(from16, within: self),
            let to = String.Index(to16, within: self)
            else { return nil }
          return from ..< to
    }
    
    func textSize(font : UIFont, size : CGSize, lineBreakMode : NSLineBreakMode) -> CGSize? {

        let textStr : NSString = self as NSString
        var textSize : CGSize?
        if size.equalTo(CGSize.zero) {
            let attributes : NSDictionary = NSDictionary.init(object: font, forKey: NSAttributedString.Key.font as NSCopying)
            textSize = textStr.size(withAttributes: attributes as? [NSAttributedString.Key : Any])
        }else{

            let resultSize : CGSize = CGSize.zero
            if textStr.length <= 0 {
                return resultSize
            }

            let option : NSStringDrawingOptions = NSStringDrawingOptions(rawValue: NSStringDrawingOptions.truncatesLastVisibleLine.rawValue | NSStringDrawingOptions.usesLineFragmentOrigin.rawValue | NSStringDrawingOptions.usesFontLeading.rawValue)
            let attributes : NSDictionary = NSDictionary.init(object: font, forKey: NSAttributedString.Key.font as NSCopying)
            let rect : CGRect = textStr.boundingRect(with: size, options: option, attributes: attributes as? [NSAttributedString.Key : Any], context: nil)
            textSize = rect.size
        }
        return textSize
    }
    
    static func attrSize(attributes : NSMutableAttributedString, size : CGSize, lineBreakMode : NSLineBreakMode) -> CGSize? {
        var textSize : CGSize?
        let resultSize : CGSize = CGSize.zero

        let option : NSStringDrawingOptions = NSStringDrawingOptions(rawValue: NSStringDrawingOptions.truncatesLastVisibleLine.rawValue | NSStringDrawingOptions.usesLineFragmentOrigin.rawValue | NSStringDrawingOptions.usesFontLeading.rawValue)
        let rect : CGRect = attributes.boundingRect(with: size, options: option, context: nil)
        textSize = rect.size
        return textSize
    }
}


