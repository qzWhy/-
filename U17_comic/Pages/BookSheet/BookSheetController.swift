//
//  TopicViewController.swift
//  dctt_qz
//
//  Created by qingzhou on 2022/3/17.
//

import UIKit
import JXSegmentedView
class BookSheetController: BaseViewController {

    var viewControllers: [UIViewController] = []
    
    lazy var listContainerView: JXSegmentedListContainerView! = {
        return JXSegmentedListContainerView(dataSource: self)
    }()
    var segmentedDataSource = JXSegmentedTitleDataSource()
    
    lazy var segmentedView: JXSegmentedView = {
        let segY: CGFloat = SystemUtils.isIphoneX() ? 44 : 20
        let segmentedView = JXSegmentedView(frame: CGRect(x: 0, y: segY, width: screenWidth, height: 44))
        let dataSource = JXSegmentedTitleDataSource()
        segmentedDataSource = dataSource
        dataSource.itemSpacing = 20
        dataSource.isTitleZoomEnabled = true
        dataSource.titleSelectedZoomScale = 1.5
        dataSource.titleSelectedFont = UIFont.boldSystemFont(ofSize: 40)
        dataSource.titleSelectedColor = titleColor
        dataSource.titleNormalFont = UIFont.systemFont(ofSize: 20)
        dataSource.titleNormalColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        dataSource.isItemSpacingAverageEnabled = false
        dataSource.titles = ["收藏","书单","历史","下载"]
        segmentedView.dataSource = dataSource
        segmentedView.listContainer = listContainerView
        listContainerView.frame = CGRect(x: 0, y: segmentedView.frame.maxY, width: view.z_width, height: view.z_height - segmentedView.frame.maxY)
        return segmentedView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewControllers = [
            BookSheetCollectionViewController(),
            BookSheetListViewController(type: 0),
            BookSheetListViewController(type: 1),
            BookSheetListViewController(type: 2)
        ]
        self.view.addSubview(listContainerView)
        self.view.addSubview(segmentedView)
    }
    

    

}
extension BookSheetController: JXSegmentedViewDelegate, JXSegmentedListContainerViewDataSource {
    func segmentedView(_ segmentedView: JXSegmentedView, didSelectedItemAt index: Int) {
        
//        segmentedView.reloadItem(at: index)
//        navigationController?.interactivePopGestureRecognizer?.isEnabled = (segmentedView.selectedIndex == 0)
    }
    func numberOfLists(in listContainerView: JXSegmentedListContainerView) -> Int {
        if let titleDataSource = segmentedView.dataSource as? JXSegmentedBaseDataSource {
            return titleDataSource.dataSource.count
        }
        return 0
    }
    func listContainerView(_ listContainerView: JXSegmentedListContainerView, initListAt index: Int) -> JXSegmentedListContainerViewListDelegate {
        let containerview = viewControllers[index]
        return containerview as! JXSegmentedListContainerViewListDelegate
    }
}
