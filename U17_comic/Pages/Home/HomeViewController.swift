//
//  HomeViewController.swift
//  dctt_qz
//
//  Created by qingzhou on 2022/3/17.
//  首页

import UIKit
import JXSegmentedView
import CWLog

class HomeViewController: UIViewController {
    
    lazy var listContainerView: JXSegmentedListContainerView! = {
        return JXSegmentedListContainerView(dataSource: self)
    }()
    
    var segmentedDataSource: JXSegmentedBaseDataSource?
    
//    var segmentedDataSource: JXSegmentedDotDataSource?
    
    var comicModel: ComicModel?
    
    var viewControllers : [UIViewController] = []
    
    var titles: [QTitleModel] = []
    
    lazy var segmentedView: JXSegmentedView = {
        let segY: CGFloat = SystemUtils.isIphoneX() ? 44 : 20
        
        let segmentedView = JXSegmentedView(frame: CGRect(x: 0, y: segY, width: screenWidth, height: 44))
        segmentedView.backgroundColor = .clear
        segmentedView.contentScrollView?.isScrollEnabled = false
        let dataSource = JXSegmentedDotDataSource()
        dataSource.itemSpacing = 34
        dataSource.isTitleZoomEnabled = true
        dataSource.titleSelectedZoomScale = 1.3
        dataSource.isTitleStrokeWidthEnabled = true
        dataSource.titleSelectedFont = UIFont.boldSystemFont(ofSize: 30)
        dataSource.titleSelectedColor = titleColor
        dataSource.titleNormalFont = UIFont.systemFont(ofSize: 20)
        dataSource.titleNormalColor = .white
        dataSource.isTitleColorGradientEnabled = true
        dataSource.isItemSpacingAverageEnabled = false
        let indicator = JXSegmentedIndicatorGradientLineView()
        indicator.backgroundColor = UIColor.clear
        indicator.clipsToBounds = true
        indicator.indicatorHeight = 10
        indicator.indicatorPosition = .center
        indicator.verticalOffset = 6
        indicator.isIndicatorWidthSameAsItemContent = true
        indicator.colors =  [
            UIColor.colorRGBA(r: 255, g: 108, b: 71, a: 1),
            UIColor.colorRGBA(r: 255, g: 108, b: 71, a: 0)
        ]
        segmentedView.indicators = [indicator]
        
        dataSource.titles = self.titles.map({ model in
            return model.title!
        })

        dataSource.dotStates = self.titles.map({ model in
            return false
        })
        segmentedDataSource = dataSource
        segmentedView.dataSource = segmentedDataSource
        segmentedView.delegate = self
        segmentedView.listContainer = listContainerView
        segmentedView.listContainer?.contentScrollView().isScrollEnabled = false
        listContainerView.frame = CGRect.init(x: 0, y: 0, width: view.z_width, height: view.z_height - segmentedView.frame.maxY)

        return segmentedView
    }()
    
    lazy var bgImgView:UIView = {
        let bgView = UIView()
        bgView.backgroundColor = .random()
        return bgView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        qz_tintColor = .red
        qz_barAlpha = 0
        
        loadData()
    }
    
    func sericalQueue() {
        
        let item1 = DispatchWorkItem {
            self.loadData()
        }
        let item2 = DispatchWorkItem {
//            self.loadComicData()
        }
        
        let serialQueue = DispatchQueue(label: "update")
        serialQueue.async(execute: item1)
        serialQueue.async(execute: item2)
    }

    
}

extension HomeViewController: JXSegmentedViewDelegate, JXSegmentedListContainerViewDataSource {
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


/** 网络请求 */
extension HomeViewController {
    func loadData() {
        let device_id = "69EACCA0-47C8-40EE-835F-7C02D8105F93"
        let model = "iPhone%207%20Plus"
        let sTime = "1624922081"
        let systemVersion = "13.3.1"
        let target = "U17_3.0"
        let time = "1649726510"
        let version = "5.8.0"
        
        ApiLoadingProvider.request(NetManager.Recommend(device_id: device_id, model: model, sTime: sTime, systemVersion: systemVersion, target: target, time: time, version: version), model: Array<QTitleModel>.self) { returnData in
            self.titles = returnData!
            for model in self.titles {
                if model.id == "8" {
                    self.viewControllers.append(UpdateViewController())
                } else if model.id == "0" {

                    self.viewControllers.append(ComicViewController())
                }
                else {
                    self.viewControllers.append(HomeListViewController(type: model.id!))
                }
            }
            self.view.addSubview(self.listContainerView)
            self.navigationItem.titleView = self.segmentedView
//            self.view.addSubview(self.segmentedView)
            self.segmentedView.defaultSelectedIndex = 1
            self.segmentedView.reloadData()
            
        }
    }
}


extension HomeViewController {

}
