//
//  UpdateListViewController.swift
//  U17_comic
//
//  Created by qingzhou on 2022/4/14.
//

import UIKit
import HandyJSON

class UpdateListViewController: BaseViewController {

    //第几天
    var day: Int = 0
    //第几页
    var page: Int = 0
    
    var comics: [InfoModel] = []
    
    init(day: Int) {
        super.init(nibName: nil, bundle: nil)
        self.day = day
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .random()
        
        self.view.addSubview(self.tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(self.view)
        }
        loadData()
    }


}

extension UpdateListViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.comics.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UpdateTableViewCell", for: indexPath) as! UpdateTableViewCell
        cell.model = self.comics[indexPath.row]
        return cell
    }
}


extension UpdateListViewController {
    func loadData() {
        
        let device_id = "69EACCA0-47C8-40EE-835F-7C02D8105F93"
        let model = "iPhone%207%20Plus"
        let systemVersion = "13.3.1"
        let target = "U17_3.0"
        let version = "5.8.0"
        
        let time = SystemUtils.getCurrentSecTime()
        debugPrint(time)
        
        let param = [
            "android_id":"iphone",
            "day": self.day,
            "device_id": device_id,
            "model" : model,
            "page": self.page,
            "systemVersion": systemVersion,
            "target": target,
            "time" : time,
            "version": version
        ] as [String : Any]
        debugPrint(param)
        QZNetWorkManager().request(path: todayRecommendList_url, params: param) { response in
            if let data = response.data, let returnData = data["data"]{
                let json = returnData as! NSDictionary
                let update = json["returnData"] as! NSDictionary
                let model = JSONDeserializer<UpdateModel>.deserializeFrom(dict: update)
                if self.page == 0 {
                    self.comics.removeAll()
                }
                self.comics.append(contentsOf: model!.comics)
                debugPrint(model)
                self.tableView.reloadData()
                
            }
        } errorBlock: { error in
            debugPrint(error)
        }
    }
    
    func loadDataSource() {
        let device_id = "69EACCA0-47C8-40EE-835F-7C02D8105F93"
        let model = "iPhone%207%20Plus"
        let systemVersion = "13.3.1"
        let target = "U17_3.0"
        let version = "5.8.0"
        
        let time = SystemUtils.getCurrentSecTime()
        debugPrint(time)
        
        ApiLoadingProvider.request(NetManager.todayRecommend(android_id: "iphone", day: self.day, device_id: device_id, model: model, page: 0, systemVersion: systemVersion, target: target, time: "1649928327", version: version), model: UpdateModel.self) { returnData in
            debugPrint(returnData)
        }
    }
}
