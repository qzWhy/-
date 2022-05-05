//
//  BaseViewController.swift
//  Owner
//
//  Created by 中时通 on 2022/1/26.
//  Copyright © 2022 轻舟. All rights reserved.
//

import UIKit
import JXSegmentedView

class BaseViewController: UIViewController {

    lazy var tableView: UITableView = {
        let table = UITableView.init(frame: .zero, style: .grouped)
        table.separatorStyle = .none
        if #available(iOS 11.0, *) {
            table.contentInsetAdjustmentBehavior =  .never;
        } else {
          self.automaticallyAdjustsScrollViewInsets = false;
        }
        table.register(HomeListTableViewCell.self, forCellReuseIdentifier: "HomeListTableViewCell")
        table.register(UpdateTableViewCell.self, forCellReuseIdentifier: "UpdateTableViewCell")
        table.register(ComicUIType1Cell.self, forCellReuseIdentifier: "ComicUIType1Cell")
        table.register(AdTableviewCell.self, forCellReuseIdentifier: "AdTableviewCell")
        //ComicUIType2ModuleType1Cell
        table.register(ComicUIType4Cell.self, forCellReuseIdentifier: "ComicUIType4Cell")
        table.register(ComicUITYpe4ModuleType1Cell.self, forCellReuseIdentifier: "ComicUITYpe4ModuleType1Cell")
        table.register(ComicUIType3MoudleType1Cell.self, forCellReuseIdentifier: "ComicUIType3MoudleType1Cell")
        table.register(ComicUIType1ModuleType4Cell.self, forCellReuseIdentifier: "ComicUIType1ModuleType4Cell")
        table.register(ComicUIType2ModuleType1Cell.self, forCellReuseIdentifier: "ComicUIType2ModuleType1Cell")
        table.register(HeaderView.self, forHeaderFooterViewReuseIdentifier: "HeaderView")
        table.register(TableHeaderTitleView.self, forHeaderFooterViewReuseIdentifier: "TableHeaderTitleView")
        table.register(CommentTableviewCell.self, forCellReuseIdentifier: "CommentTableviewCell")
        table.register(BookSheetViewCell.self, forCellReuseIdentifier: "BookSheetViewCell")
        table.delegate = self
        table.dataSource = self
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .clear
//        if navigationController?.viewControllers.count ?? 0 > 1 {
//            self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "project_back"), style: .plain, target: self, action: #selector(backClick))
//        }
        
    }
    @objc func backClick() {
        self.navigationController?.popViewController(animated: true)
    }
}
extension BaseViewController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LoadGoodInfoCell", for: indexPath)
        return cell
    }
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 56
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 8
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
            
            //圆角半径
            let cornerRadius: CGFloat = 12
            // 设置cell的背景色为透明，如果不设置这个的话，则原来的背景色不会被覆盖
            cell.backgroundColor = .clear
            
            // 创建一个shapeLayer
            let layer: CAShapeLayer = CAShapeLayer()           //默认样式
            let backgroundLayer: CAShapeLayer = CAShapeLayer() //选中样式
            // 获取cell的size
            // 第一个参数,是整个 cell 的 bounds, 第二个参数是距左右两端的距离,第三个参数是距上下两端的距离
            let bounds = cell.bounds.insetBy(dx: 0, dy: 0)
            // 这里要判断分组列表中的第一行，每组section的第一行，每组section的中间行
            let row: NSInteger = indexPath.row
            //最后一行
            let lastRow = tableView.numberOfRows(inSection: indexPath.section) - 1

            var maskPath: UIBezierPath = UIBezierPath()
            let cornerSize: CGSize = CGSize.init(width: cornerRadius, height: cornerRadius)
            //如果即使第一行也是最后一行,只有一个cell 四个圆角
            if (row == 0 && row == lastRow)
            {
                maskPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: .allCorners, cornerRadii: cornerSize)
            }
                //第一行
            else if(row == 0)
            {
                maskPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: cornerSize)
            }
                //最后一行
            else if (row == lastRow)
            {
                maskPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: cornerSize)
            }else
            {
                //添加cell的rectangle信息到path中（不包括圆角）
                maskPath = UIBezierPath(rect: bounds)
            }
            
            layer.path = maskPath.cgPath
            backgroundLayer.path = maskPath.cgPath
            
            // 按照shape layer的path填充颜色，类似于渲染render
            layer.fillColor = UIColor.white.cgColor
            
            // view大小与cell一致
            let roundView = UIView.init(frame: bounds)
            // 添加自定义圆角后的图层到roundView中
            roundView.layer.insertSublayer(layer, at: 0)
            roundView.backgroundColor = .clear
            // cell的背景view
            cell.backgroundView = roundView
            
        }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let offsetY = scrollView.contentOffset.y
        let parma = [
            "offsetY" : offsetY
        ]
        
        NotificationCenter.default.post(name: NSNotification.Name.init(rawValue: "OFFSETY"), object: nil, userInfo: parma)
    }
}

extension BaseViewController: JXSegmentedListContainerViewListDelegate {
    func listView() -> UIView {
        return view
    }
    
}

