//
//  ComicViewController.swift
//  U17_comic
//
//  Created by qingzhou on 2022/4/15.
//  漫画

import UIKit
import SDCycleScrollView
import SnapKit
import HandyJSON

class ComicViewController: BaseViewController {

    var comic: ComicModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.tableView)
        self.tableView.backgroundColor = .white
        loadComicData()
        
        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
}

extension ComicViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return (comic?.modules?.count) ?? 0
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let module: moduleModel = (comic?.modules![indexPath.section])!
        if module.moduleType == "2" && module.uiType == "1" {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AdTableviewCell", for: indexPath) as! AdTableviewCell
            cell.model = module
            return cell
        }
        else if module.moduleType == "2" && module.uiType == "4" {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ComicUIType4Cell", for: indexPath) as! ComicUIType4Cell
            
            let arr = module.items! as! [Any]
            var items:[itemModel1] = []

            for model in arr {
                let mm = model as! [String : Any]
                let item = JSONDeserializer<itemModel1>.self.deserializeFrom(dict: mm)
                items.append(item!)
            }
            cell.itemArr = items as? [itemModel1]
            return cell
        }
        else if module.moduleType == "1" && module.uiType == "4" {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ComicUITYpe4ModuleType1Cell", for: indexPath) as! ComicUITYpe4ModuleType1Cell
            let arr = module.items! as! [Any]
            var items:[itemModel] = []
            for item in arr {
                debugPrint(item)
                let arr1 = item as! [Any]
                let count = arc4random_uniform(UInt32(arr1.count))
                let item1:NSDictionary = arr1[Int(count)] as!      NSDictionary
                let model = JSONDeserializer<itemModel>.self.deserializeFrom(dict: item1)!
                
                items.append(model)
            }
            cell.itemArr = items
            return cell
        }
        else if module.moduleType == "1" && module.uiType == "3" {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ComicUIType3MoudleType1Cell", for: indexPath) as! ComicUIType3MoudleType1Cell
            let arr = module.items! as! [Any]
            var items:[itemModel] = []
            for item in arr {
                debugPrint(item)
                let arr1 = item as! [Any]
                let count = arc4random_uniform(UInt32(arr1.count))
                let item1:NSDictionary = arr1[Int(count)] as! NSDictionary
                let model = JSONDeserializer<itemModel>.self.deserializeFrom(dict: item1)!
                
                items.append(model)
            }
            cell.itemArr = items
            return cell
        }
        else if module.moduleType == "4" && module.uiType == "1" {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "ComicUIType1ModuleType4Cell", for: indexPath) as! ComicUIType1ModuleType4Cell
            let arr = module.items! as! [Any]
            var items:[itemModel] = []

            for model in arr {
                let mm = model as! [String : Any]
                let item = JSONDeserializer<itemModel>.self.deserializeFrom(dict: mm)
                items.append(item!)
            }
            cell.itemArr = items
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ComicUIType1Cell", for: indexPath) as! ComicUIType1Cell
        cell.itemDidClickBlock = {index in
            debugPrint(index)
            let comicvc = ComicIndexPageVC()
            self.navigationController?.pushViewController(comicvc, animated: true)
        }
        let arr = module.items! as! [Any]
        var items:[itemModel] = []
        for item in arr {
            debugPrint(item)
            let arr1 = item as! [Any]
            let count = arc4random_uniform(UInt32(arr1.count))
            let item1:NSDictionary = arr1[Int(count)] as! NSDictionary
            let model = JSONDeserializer<itemModel>.self.deserializeFrom(dict: item1)!
            
            items.append(model)
        }
        cell.itemArr = items
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "HeaderView") as! HeaderView
            header.backgroundColor = .white
            header.title = self.comic?.modules?[section].moduleInfo?.title
            header.model = self.comic
            return header
        } else {
            let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "TableHeaderTitleView") as! TableHeaderTitleView
            header.title = self.comic?.modules?[section].moduleInfo?.title
            return header
        }
        
        
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let module: moduleModel = (comic?.modules![section])!
        if module.moduleType == "2" && module.uiType == "1" {
            return 0.01
        }
        if section == 0 {
            return 560
        }
        return 60
    }
    
}
extension ComicViewController {
    func loadComicData() {
        let device_id = "69EACCA0-47C8-40EE-835F-7C02D8105F93"
        let model = "iPhone%207%20Plus"
        let systemVersion = "13.3.1"
        let target = "U17_3.0"
        let version = "5.8.0"
        let time = SystemUtils.getCurrentSecTime()
        debugPrint(time)
        let param = [
            "device_id":device_id,
            "model":model,
            "systemVersion":systemVersion,
            "target":target,
            "version":version,
            "time":time
        ]
        //311.6 2804.5
        QZNetWorkManager().request(path: comic_url, params: param) { response in
            
            debugPrint("111")
            
            let model1: ComicModel = SystemUtils.handyJson(ComicModel.self, response: response)
            self.comic = model1
            
            let arr: [galleryItemModel] = model1.galleryItems!
            var imgs: [String] = []
            for item in arr {
                imgs.append(item.topCover ?? "")
            }
//            self.cycleScrollView.imageURLStringsGroup = imgs
            self.tableView.reloadData()
            
        } errorBlock: { error in
            debugPrint(error)
        }


    }
}


