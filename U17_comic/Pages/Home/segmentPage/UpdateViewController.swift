//
//  UpdateViewController.swift
//  dctt_qz
//
//  Created by qingzhou on 2022/4/14.
//  更新


import UIKit
import CWLog
import HandyJSON
import JXSegmentedView

class UpdateViewController: BaseViewController {

    var updateModel: UpdateModel?
    
    var segmentedDataSource: JXSegmentedBaseDataSource?
    
    var viewControllers : [UIViewController] = []
    
    var days:[Int] = []
    //第几天
    var day: Int = 0
    //第几页
    var page: Int = 0
    
    var comics: [InfoModel] = []
    
    lazy var listContainerView: JXSegmentedListContainerView! = {
        return JXSegmentedListContainerView(dataSource: self)
    }()
    
    lazy var segmentedView: JXSegmentedView = {
        let segmentedView = JXSegmentedView(frame: CGRect(x: 0, y: SystemUtils.getNavHeight() + SystemUtils.getStatusHeight(), width: screenWidth, height: 44))
        segmentedView.contentScrollView?.isScrollEnabled = false
        let dataSource = JXSegmentedTitleDataSource()
        
        dataSource.itemSpacing = 20
        dataSource.itemWidth = (screenWidth - 8*20) / 7
        dataSource.isTitleStrokeWidthEnabled = true
        dataSource.titleSelectedFont = UIFont.systemFont(ofSize: 16)
        dataSource.titleSelectedColor = UIColor.colorWithRGBHex(hex: 0x87DFA9)
        dataSource.titleNormalFont = UIFont.systemFont(ofSize: 16)
        dataSource.titleNormalColor = UIColor.colorWithRGBHex(hex: 0x000E18)
        dataSource.isTitleColorGradientEnabled = true
        dataSource.isItemSpacingAverageEnabled = false
        let indicator = JXSegmentedIndicatorGradientLineView()
        indicator.backgroundColor = UIColor.clear
        indicator.clipsToBounds = true
        indicator.indicatorHeight = 10
        indicator.indicatorPosition = .bottom
        indicator.verticalOffset = 6
        indicator.isIndicatorWidthSameAsItemContent = true
        indicator.colors =  [
            UIColor.colorRGBA(r: 255, g: 108, b: 71, a: 1),
            UIColor.colorRGBA(r: 255, g: 108, b: 71, a: 0)
        ]
        segmentedView.indicators = [indicator]
        
        let array = SystemUtils.getWeeks()
        
        dataSource.titles = array[0] as! [String]
        self.days = array[1] as! [Int]
        segmentedDataSource = dataSource
        segmentedView.dataSource = segmentedDataSource
        segmentedView.delegate = self
        segmentedView.listContainer = listContainerView
        segmentedView.listContainer?.contentScrollView().isScrollEnabled = false
        listContainerView.frame = CGRect.init(x: 0, y: segmentedView.frame.maxY, width: view.z_width, height: view.z_height - segmentedView.frame.maxY - SystemUtils.getTabBarHeight())

        return segmentedView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let array = SystemUtils.getWeeks()
        self.days = array[1] as! [Int]
        
        viewControllers = [
            UpdateListViewController(day: self.days[0]),
            UpdateListViewController(day: self.days[1]),
            UpdateListViewController(day: self.days[2]),
            UpdateListViewController(day: days[3]),
            UpdateListViewController(day: days[4]),
            UpdateListViewController(day: days[5]),
            UpdateListViewController(day: days[6]),
        ]
        self.view.addSubview(self.segmentedView)
        segmentedView.defaultSelectedIndex = 6
        self.view.addSubview(self.listContainerView)
        self.day = SystemUtils.getDay()
//        loadData()
    }
}

extension UpdateViewController: JXSegmentedViewDelegate, JXSegmentedListContainerViewDataSource {
    func segmentedView(_ segmentedView: JXSegmentedView, didSelectedItemAt index: Int) {
        if let dotDataSource = segmentedDataSource as? JXSegmentedDotDataSource {
            //先更新数据源的数据
            dotDataSource.dotStates[2] = false
            //再调用reloadItem(at: index)
            segmentedView.reloadItem(at: index)
        }
        navigationController?.interactivePopGestureRecognizer?.isEnabled = (segmentedView.selectedIndex == 0)
    }
    
    func numberOfLists(in listContainerView: JXSegmentedListContainerView) -> Int {
        if let titleDataSource = segmentedView.dataSource as? JXSegmentedBaseDataSource {
            return titleDataSource.dataSource.count
        }
        return 0
    }
    func listContainerView(_ listContainerView: JXSegmentedListContainerView, initListAt index: Int) -> JXSegmentedListContainerViewListDelegate {
        
        let containerView = viewControllers[index]
        return containerView as! JXSegmentedListContainerViewListDelegate
    }
}


extension UpdateViewController {
    func loadData() {
        
        let device_id = "69EACCA0-47C8-40EE-835F-7C02D8105F93"
        let model = "iPhone%207%20Plus"
        let systemVersion = "13.3.1"
        let target = "U17_3.0"
        let version = "5.8.0"
        
        let param = [
            "android_id":"iphone",
            "day": "\(self.day)",
            "device_id": device_id,
            "model" : model,
            "page": self.page,
            "systemVersion": systemVersion,
            "target": target,
            "time" : SystemUtils.getCurrentSecTime(),
            "version": version
        ] as [String : Any]
        
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
                
            }
        } errorBlock: { error in
            debugPrint(error)
        }
    }
}
