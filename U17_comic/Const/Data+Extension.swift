//
//  NSData+Extension.swift
//  zhongshitong
//
//  Created by zst on 2019/4/20.
//  Copyright © 2019 jusa. All rights reserved.
//

import Foundation

extension Data {

    func base64EncodedStringWithWrapWidth(wrapWidth : Int) -> String? {
        if self.count <= 0 {
            return nil
        }
        var encoded : String?
        var wrap : Int = wrapWidth
        switch wrapWidth {
        case 64:
            encoded = self.base64EncodedString(options: Data.Base64EncodingOptions.lineLength64Characters)
        case 76:
            encoded = self.base64EncodedString(options: Data.Base64EncodingOptions.lineLength76Characters)
        default:
            encoded = self.base64EncodedString(options: Data.Base64EncodingOptions.endLineWithLineFeed)
        }
        if wrap == 0 || wrap >= (encoded?.count)! {
            return encoded
        }
        wrap = (wrap / 4) * 4
        var i : Int = 0
        var result : String = ""
        while i < (encoded?.count)!{

            if i + wrap >= (encoded?.count)! {
                
                let subIndex : String.Index  = (encoded?.index((encoded?.startIndex)!, offsetBy: i))!
                result.append(String((encoded?[subIndex...])!))
                break
            }
            let startIndex : String.Index = (encoded?.index((encoded?.startIndex)!, offsetBy: i))!
            let endIndex : String.Index = (encoded?.index(startIndex, offsetBy: wrap))!
            result.append(String((encoded?[startIndex..<endIndex])!))
            result.append("\r\n")
            i = i + wrap
        }
        return result
    }
    
    func toBase64EncodedString() -> String? {
        return self.base64EncodedStringWithWrapWidth(wrapWidth: 0)
    }
    
//    /*
//     * 把base64转化成data
//     */
//    func toBase64EncodedData() -> Data? {
//        let string : String? = self.base64EncodedStringWithWrapWidth(wrapWidth: 0)
//        if string != nil {
//            return string!.data(using: String.Encoding.utf8, allowLossyConversion: true)
//        }
//        return nil
//    }
    
}
