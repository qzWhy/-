//
//  NSObject+Extension.swift
//  zhongshitong
//
//  Created by zst on 2019/4/20.
//  Copyright © 2019 jusa. All rights reserved.
//

import Foundation

extension NSObject {
    
    func String_to_ViewController(_ childControllerName: String) -> UIViewController?{
        
        // 1.获取命名空间
        guard let clsName = Bundle.main.infoDictionary!["CFBundleExecutable"] else {
            print("命名空间不存在")
            return nil
        }
        // 2.通过命名空间和类名转换成类
        let cls : AnyClass? = NSClassFromString((clsName as! String) + "." + childControllerName)
        
        // swift 中通过Class创建一个对象,必须告诉系统Class的类型
        guard let clsType = cls as? UIViewController.Type else {
            print("无法转换成UIViewController")
            return nil
        }
        // 3.通过Class创建对象
        let childController = clsType.init()
        
        return childController
    }
    
    static func checkNull(obj : Any) -> Any {
        
        if obj is Dictionary<String, Any> {
            return self.nullDic(dictionary: obj as! Dictionary<String, Any>)
        }else if obj is Array<Any> {
            return self.nullArr(array: obj as! Array)
        }else if obj is NSNull {
            return ""
        }
        return obj
    }
    
    static func nullArr(array : Array<Any>) -> Array<Any> {
        var mutableArr : Array = array
        
        for i in 0..<mutableArr.count {
            var obj : Any = mutableArr[i]
            obj = NSObject.checkNull(obj: obj)
            mutableArr[i] = obj
        }
        return mutableArr
    }
    
    static func nullDic(dictionary : Dictionary<String, Any>) -> Dictionary<String, Any> {
        var mutableDic : Dictionary = dictionary
        for (key, value) in mutableDic {
            let va : Any = NSObject.checkNull(obj: value)
            mutableDic[key] = va
        }
        return mutableDic
    }

}

