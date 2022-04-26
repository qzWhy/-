//
//  NetWorkManager.swift
//  U17_comic
//
//  Created by qingzhou on 2022/4/25.
//

import UIKit
import SwiftyJSON
import Alamofire
//网络请求返回数据结构体
public struct DataResult {
    ///对应code值
    var code : String = ""
    ///加载完成后的信息
    var msg : String = ""
    ///是否加载成功
    var success : Bool = false
    ///返回列表数据  仅在列表类数据加载中有用
    var listArray : Array<NSDictionary> = []
    ///返回未处理的数据
    var json : JSON = JSON()
    ///系统时间
    var time : String = ""
    ///总页数
    var totalPage : Int = 0
    
    init(code: String,msg: String,success:Bool, listArray:Array<NSDictionary>?) {
        self.code = code
        self.msg = msg
        self.success = success
        if listArray != nil {
            self.listArray = listArray!
        }
    }
}

class NetWorkManager: NSObject {

    static let shared = NetWorkManager.init()
    
    static var onClickNum: Bool = false
    
    static var appIsShow: Bool = false
    
    static var userIsLogin: Bool = false
    
    static var loginIsShow: Bool = false
    
    private override init() {}
    
    static func picDownLoadAPI() {
        
    }
    
    @objc static func startDownloadImage(urlString: String?) {
        guard let temp = urlString else { return }
        if temp.count <= 0 { return }
        if let tempImage = NetWorkManager.isExistFile() {
            if tempImage == temp { return }
        }
        let urlstr = "https://img-oss.u17i.com/5/15/12/112485/1310592_1450247328_4WV1Os4WwMDO.65ed7_svol.jpg"
        let des: DownloadRequest.Destination = { _, _ in
            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let fileURL = documentsURL.appendingPathComponent("mm.png")
            return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
        }
        AF.download(urlstr, interceptor: nil, to: des).downloadProgress { progress in
            debugPrint(progress)
        }.responseData { res in
            if let data = res.value {
                let image = UIImage(data: data)
                debugPrint(image)
            }
        }
    }
    
    static func isExistFile() -> String? {
        guard let path = pathOfSTPlist() else { return nil }
        var isDir: ObjCBool = false
        let fileManager: FileManager = FileManager.default
        let existed:Bool = fileManager.fileExists(atPath: path, isDirectory: &isDir)
        if existed {
            let dic : NSDictionary? = NSDictionary.init(contentsOfFile: path)
            if let temp = dic {
                return temp["imagePath"] as? String
            } else {
                return nil
            }
        }
        return nil
    }
    
    @objc static func pathOfSTPlist() -> String? {
        guard let temp = downloadPath() else { return nil }
        return (temp as NSString).appendingPathComponent("STARTIMAGE.plist")
    }
    
    static func downloadPath() -> String? {
        let documentPath: NSString? = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first as NSString?
        guard let temp = documentPath else { return nil }
        let downloadPath : String = temp.appendingPathComponent("startImages")
        return downloadPath
    }
}
