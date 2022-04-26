//
//  SystemUtils.swift
//  Owner
//
//  Created by 中时通 on 2022/1/18.
//  Copyright © 2022 轻舟. All rights reserved.
//

import UIKit
import Kingfisher
import HandyJSON
import SnapKit

var topVC: UIViewController? {
    var resultVC: UIViewController?
    resultVC = _topVC(UIApplication.shared.windows.last?.rootViewController)
    while resultVC?.presentedViewController != nil {
        resultVC = _topVC(resultVC?.presentedViewController)
    }
    return resultVC
}

private func _topVC(_ vc: UIViewController?) -> UIViewController? {
    if vc is UINavigationController {
        return _topVC((vc as? UINavigationController)?.topViewController)
    } else if vc is UITabBarController {
        return _topVC((vc as? UITabBarController)?.selectedViewController)
    } else {
        return vc
    }
}

class SystemUtils: NSObject {
    
    static func getStatusHeight() -> CGFloat {
        let statusHeight = UIApplication.shared.statusBarFrame.size.height
        return statusHeight
    }
    
    static func getIsIphoneX() -> Bool {
        let statusHeight = UIApplication.shared.statusBarFrame.size.height
        if statusHeight > 20 {
            return true
        }
        return false
    }
    
    //MARK:屏幕宽度
    static func screenWidth() ->CGFloat {
       return  min(UIScreen.main.bounds.height, UIScreen.main.bounds.width)
    }
    //MARK:屏幕高度
    static  func screenHeight() -> CGFloat {
        return  max(UIScreen.main.bounds.height, UIScreen.main.bounds.width)
    }
    //判断是否是刘海屏
    static func isIphoneX() -> Bool {
        let isiphonex = UIApplication.shared.statusBarFrame.height >= 44
        return isiphonex
    }
    
    static func getKeyWindow() -> UIWindow? {
        var window: UIWindow?
//        if #available(iOS 13.0, *) {
            //            for windowScene in UIApplication.shared.connectedScenes {
            //                if windowScene.activationState == .foregroundActive {
//            let scene: UIWindowScene = windowScene as! UIWindowScene
//            window = scene.windows[0]
//            break
            //                }
            //            }
//        }else{
            
            window = UIApplication.shared.keyWindow
//        }
        return window
    }
    
    ///获取导航栏高度
    static func getNavHeight()->CGFloat{
        if let nav = QZBaseTabBarViewController.shared.navigationController?.navigationBar{
            return nav.frame.size.height
        }
        return 44
    }
    
    //MARK:底部导航栏高度
    static  func getTabBarHeight() -> CGFloat {
        return UITabBarController().tabBar.frame.size.height + (isIphoneX() ? 34.0 : 0)
    }
    
    //MARK:计算文字宽度
    static func computerTextWidth(text:String,font:UIFont,height:CGFloat)->CGFloat{
        let attArray = [NSAttributedString.Key.font : font]
        let rect = (text as NSString).boundingRect(with: CGSize.init(width: 200, height: height), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: attArray, context: nil)
        return rect.size.width + 5
    }
    
    //MARK:数字
    static func isNumber(_ input: String?) -> Bool {
        let NUMBERS = "0.10123456789"
        let cs = NSCharacterSet.init(charactersIn: NUMBERS).inverted
        let filtered = input?.components(separatedBy: cs).joined(separator: "")
        let basicTest = input?.isEqual(filtered)
        return  basicTest!
    }
    
    //MARK:整数
    static func isIntNumber(_ input: String?) -> Bool {
        let NUMBERS = "10123456789"
        let cs  = NSCharacterSet.init(charactersIn: NUMBERS).inverted
        let filtered = input?.components(separatedBy: cs).joined(separator: "")
        let basicTest = input?.isEqual(filtered)
        return  basicTest!
        
    }
    
    //MARK:数量输入验证规则
    static func textInputwithNumber(_ text : String?) -> String {
        if text == nil{
            return ""
        }
        let rtext = text! as NSString
        if rtext.isEqual(to: ""){
            return ""
        }
        var resultText = rtext
        if !self.isNumber(text){
            resultText = NSString.init(format: "%.3f", rtext.doubleValue)
        }else{
            if resultText.hasPrefix("00"){
                if resultText.doubleValue > 0{
                    resultText = resultText.substring(from: 1) as NSString
                }else{
                    resultText = "0"
                }
            }
            if resultText.hasPrefix("."){
                resultText = "0."
            }
            if resultText.contains(".") {
                if resultText.contains(".."){ //含..
                    if resultText.hasSuffix("..")  {  //末尾含..
                        resultText = resultText.substring(to: resultText.length-1) as NSString
                    }else{
                        resultText = NSString.init(format: "%.3f", resultText.doubleValue)
                    }
                }
                let inde = resultText.range(of: ".")
                var point = resultText.substring(from: inde.location) as NSString
                var removePointText = resultText.substring(to: inde.location) as NSString
                if removePointText.length >= 8{
                    removePointText = removePointText.substring(to: 8) as NSString
                }
                if point.length > 4{
                    point = point.substring(to: 4) as NSString
                }

                //判断12.3.3情况
                if removePointText.doubleValue < resultText.doubleValue && point.hasSuffix("."){
                    point = point.substring(to: point.length-1) as NSString
                }
                resultText = removePointText.appending(point as String) as NSString

                //判断12.0.1
                if point.length > 1{
                    if (point.substring(from: 1) as NSString).contains("."){
                        resultText = NSString.init(format: "%.3f", resultText.doubleValue)
                    }
                }

                //判断0.0.0
                if resultText.doubleValue <= 0 && point.length > 1{
                    if (point.substring(from: 1) as NSString).contains("."){
                        resultText = "0."
                    }
                }
            }else{
                if resultText.length > 8{
                    resultText = resultText.substring(to: 8) as NSString
                }
            }
            if resultText.doubleValue >= 1 && rtext.hasPrefix("0"){
                if !self.isIntNumber(rtext as String){
                    resultText = NSString.init(format: "%.3f", resultText.doubleValue)
                }else{
                    resultText = NSString.init(format: "%.0f", resultText.doubleValue)
                }
            }
        }
        return resultText as String
    }
    //MARK:手机号验证  正则表达式改在 IPhoneMethod.m 中获取
    ///手机号验证规则 即时通讯 NIMSessionTextContentView.m 文件中也有使用
    static func isPhonenumber(_ number: String?) -> Bool {
        guard let phone = number, !phone.isEmpty else {
            return false
        }

        let pattern = "^1(3|4|5|6|7|8|9)\\d{9}$"
        let predicate = NSPredicate.init(format: "SELF MATCHES %@", pattern)
        return predicate.evaluate(with: phone)
    }
    //MARK:价格输入判断
    static func textInputWithMoney(_ text:String?)->String{
        if text == nil{
            return ""
        }
        let rtext = text! as NSString
        if rtext.isEqual(to: ""){
            return ""
        }
        var resultText = rtext
        if !self.isNumber(text){
            resultText = NSString.init(format: "%.2f", rtext.doubleValue)
        }else{
            if resultText.hasPrefix("00"){
                if resultText.doubleValue > 0{
                    resultText = resultText.substring(from: 1) as NSString
                }else{
                    resultText = "0"
                }
            }
            if resultText.hasPrefix("."){
                resultText = "0."
            }
            if resultText.contains(".") {
                if resultText.contains(".."){ //含..
                    if resultText.hasSuffix("..")  {  //末尾含..
                        resultText = resultText.substring(to: resultText.length-1) as NSString
                    }else{
                        resultText = NSString.init(format: "%.2f", resultText.doubleValue)
                    }
                }
                let inde = resultText.range(of: ".")
                var point = resultText.substring(from: inde.location) as NSString
                var removePointText = resultText.substring(to: inde.location) as NSString
                if removePointText.length >= 8{
                    removePointText = removePointText.substring(to: 8) as NSString
                }
                if point.length > 3{
                    point = point.substring(to: 3) as NSString
                }

                //判断12.3.3情况
                if removePointText.doubleValue < resultText.doubleValue && point.hasSuffix("."){
                    point = point.substring(to: point.length-1) as NSString
                }
                resultText = removePointText.appending(point as String) as NSString

                //判断12.0.1
                if point.length > 1{
                    if (point.substring(from: 1) as NSString).contains("."){
                        resultText = NSString.init(format: "%.2f", resultText.doubleValue)
                    }
                }

                //判断0.0.0
                if resultText.doubleValue <= 0 && point.length > 1{
                    if (point.substring(from: 1) as NSString).contains("."){
                        resultText = "0."
                    }
                }
            }else{
                if resultText.length > 8{
                    resultText = resultText.substring(to: 8) as NSString
                }
            }
            if resultText.doubleValue >= 1 && rtext.hasPrefix("0"){
                if !self.isIntNumber(rtext as String){
                    resultText = NSString.init(format: "%.2f", resultText.doubleValue)
                }else{
                    resultText = NSString.init(format: "%.0f", resultText.doubleValue)
                }
            }
        }

        return resultText as String
    }
    
    //MARK:整数输入判断
    static func textInputIntNumbet(text : String?)->String{
        if text == nil{
            return ""
        }
        var resultStr = text!
        if self.isIntNumber(text){
            if (resultStr as NSString).hasPrefix("0") {
                resultStr = (resultStr as NSString).replacingCharacters(in: NSRange.init(location: 0, length: 1), with: "")
            }
            if resultStr.count > 8{
                resultStr = String(resultStr.prefix(8))
            }
            return resultStr
        }
        if self.isNumber(text){
            if (resultStr as NSString).hasPrefix("."){
                resultStr = "0"
            }
            if (resultStr as NSString).contains("."){
                resultStr = (resultStr as NSString).replacingOccurrences(of: ".", with: "")
            }
            resultStr = String.init(format: "%.0f", (resultStr as NSString).doubleValue)
            if (resultStr as NSString).hasPrefix("0") {
                resultStr = (resultStr as NSString).replacingCharacters(in: NSRange.init(location: 0, length: 1), with: "")
            }
        }else{
            resultStr = ""
        }
        if resultStr.count > 8{
            resultStr = String(resultStr.prefix(8))
        }
        return resultStr
    }
    /**获取一周的排序**/
    static func getWeeks() ->Array<Any> {
        let calendar: Calendar = Calendar(identifier: .gregorian)
        var comps: DateComponents = DateComponents()
        comps = calendar.dateComponents([.year,.month,.day,.weekday,.hour,.minute,.second], from: Date())
        let weekDay = comps.weekday! - 1
        var array = ["周日","周一","周二","周三","周四","周五","周六"]
        var array1 = [7,1,2,3,4,5,6]
        array[weekDay] = "今天"
        if weekDay == 0 {
            array[6] = "昨天"
        } else {
            array[weekDay - 1] = "昨天"
        }
        let arr1 = array[weekDay...6]
        let arr2 = array[0...weekDay]
        
        let array2 = array1[weekDay...6]
        let array3 = array1[0...weekDay]
        
        var arr3:[String] = []
        var array4: [Int] = []
        for item in arr1 {
            arr3.append(item)
        }
        for item in arr2 {
            arr3.append(item)
        }
        for item in array2 {
            array4.append(item)
        }
        for item in array3 {
            array4.append(item)
        }
        arr3.remove(at: 0)
        array4.remove(at: 0)
        
        var days:Array<Any> = []
        days.append(arr3)
        days.append(array4)
        
        return days
    }
    /**今天是一周的第几天 从第零天开始**/
    static func getDay() -> Int {
        let calendar: Calendar = Calendar(identifier: .gregorian)
        var comps: DateComponents = DateComponents()
        comps = calendar.dateComponents([.year,.month,.day,.weekday,.hour,.minute,.second], from: Date())
        let weekDay = comps.weekday! - 1
        return weekDay
    }
    /**获取当前时间戳 秒级**/
    static func getCurrentSecTime() -> String {
        let timeInterval: TimeInterval = Date().timeIntervalSince1970
        let timeStamp = Int(timeInterval)
        return "\(timeStamp)"
    }
//    mapModel<T: HandyJSON>(_ type: T.Type)throws -> T
    static func handyJson<T:HandyJSON>(_ type: T.Type, response: QZResponse) -> T {
        var model: T?
        if let data = response.data, let returnData = data["data"]{
            let json = returnData as! NSDictionary
            let update = json["returnData"] as! NSDictionary
            model = JSONDeserializer<T>.deserializeFrom(dict: update)
        }
        return model!
    }
    
    static func handyJsonWithDic<T:HandyJSON>(_ type: T.Type, response: NSDictionary) -> T {
        var model: T?
        model = JSONDeserializer<T>.deserializeFrom(dict: response)
        return model!
    }
    
}

class dayModel: NSObject {
    var dayStr:String?
    var day: Int?
}


extension ConstraintView {
    var qsnp: ConstraintBasicAttributesDSL {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.snp
        } else {
            return self.snp
        }
    }
}
