//
//  DateModel.swift
//  Owner
//
//  Created by 中时通 on 2022/2/15.
//  Copyright © 2022 轻舟. All rights reserved.
//

import UIKit

class DateModel: NSObject {

    // MARK: 获取当前时间
    // 这里的 type 是指日期的格式 “yyyyMMdd” 或者 “yyyy-MM-dd” 这样子
    class func nowTime(_ type: String?) -> String {
            let currentDate = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = type ?? "MMdd"
            let time = formatter.string(from: currentDate)
            return time
        }
    class func nowYear() -> String {
            let currentDate = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy"
            let time = formatter.string(from: currentDate)
            return time
        }
    class func nowMonth() -> String {
            let currentDate = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "MM"
            let time = formatter.string(from: currentDate)
            return time
        }
    class func nowDay() -> String {
            let currentDate = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "dd"
            let time = formatter.string(from: currentDate)
            return time
        }
    /**获取从今天起之后一个月的时间**/
    class func getSubwayMonth() -> [BaseModel] {
        
        let year1 = self.nowYear()
        let month1 = self.nowMonth()
        let day1 = self.nowDay()
        
        var arr:[BaseModel] = []
        
        let days = howManyDays(inThisYear: Int(year1)!, withMonth: Int(month1)!)
        
        let month = Int(month1)
        
        let day = Int(day1)!
        for i in day...days {
            arr.append(BaseModel.init(title: "\(month1).\(i)"))
        }
        let month2 = month! + 1
        for j in 1...day {
            arr.append(BaseModel.init(title: "\(month2).\(j)"))
        }
        
        return arr
    }

    /**获取当前年份当前月有多少天**/
    class func howManyDays(inThisYear year: Int, withMonth month:Int) -> Int {
        if month == 1 || month == 3 || month == 5 || month == 7 || month == 8 || month == 10 || month == 12 {
            return 31
        }
        if month == 4 || month == 6 || month == 9 || month == 11 {
            return 30
        }
        if year % 4 == 1 || year % 4 == 2 || year % 4 == 3 {
            return 28
        }
        if year % 400 == 0 {
            return 29
        }
        if year % 100 == 0 {
            return 28
        }
        return 29
    }
    
    /**时间数组**/
    class func getTimeArray() -> [BaseModel] {
        let times: [BaseModel] = [
            BaseModel.init(title: "凌晨5:00"),
            BaseModel.init(title: "凌晨6:00"),
            BaseModel.init(title: "上午6:00-12:00"),
            BaseModel.init(title: "上午7:00"),
            BaseModel.init(title: "上午8:00"),
            BaseModel.init(title: "上午9:00"),
            BaseModel.init(title: "上午10:00"),
            BaseModel.init(title: "上午11:00"),
            BaseModel.init(title: "上午12:00"),
            BaseModel.init(title: "下午13:00"),
            BaseModel.init(title: "下午13:00-18:00"),
            BaseModel.init(title: "下午14:00"),
            BaseModel.init(title: "下午15:00"),
            BaseModel.init(title: "下午16:00"),
            BaseModel.init(title: "下午17:00"),
            BaseModel.init(title: "下午18:00"),
            BaseModel.init(title: "晚上19:00"),
            BaseModel.init(title: "晚上20:00"),
            BaseModel.init(title: "晚上21:00"),
            BaseModel.init(title: "晚上22:00"),
            BaseModel.init(title: "晚上23:00"),
            BaseModel.init(title: "晚上24:00")
        ]
        return times
    }
}
