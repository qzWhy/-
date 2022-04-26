//
//  QZBaseTabBarViewController.swift
//  Owner
//
//  Created by 中时通 on 2022/1/18.
//  Copyright © 2022 中时通. All rights reserved.
//  自定义导航栏 中间凸起按钮

import UIKit

class QZBaseTabBarViewController: UITabBarController {

    var customTabBar1 = UNTabBar()
    
    @objc static let shared = QZBaseTabBarViewController.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let customTabBar = UNTabBar()
        //取消tabBar的透明效果
        customTabBar.isTranslucent = true
        //设置tabBar的代理
//        customTabBar.myDelegate = self
        customTabBar.delegate = self
        self.customTabBar1 = customTabBar
        self.setValue(customTabBar, forKey: "tabBar")
        
//        self.customTabBar1.datePickBlock = {str in
//            debugPrint(str)
//        }
//        self.customTabBar1.dictDataBlock = {dict in
//            debugPrint(dict)
//        }
        setupTabBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    //MARK: - 控制器的信息
    func setupTabBar() {
        let homevc = HomeViewController()
        let minevc = MineViewController()
        let publishvc = PublishViewController()
        let liftvc = LifeViewController()
        let topicvc = BookSheetController()
        
        creatTabBarView(viewController: homevc, image: "home_normal", selectImage: "home_highlight", title: "发现", tag: 1)
        creatTabBarView(viewController: topicvc, image: "familiarity_car_normal", selectImage: "familiarity_car_highlight", title: "书架", tag: 2)
        creatTabBarView(viewController: publishvc, image: "transparent", selectImage: "", title: "发布", tag: 3)
        creatTabBarView(viewController: liftvc, image: "order_normal", selectImage: "order_highlight", title: "生活", tag: 4)
        creatTabBarView(viewController: minevc, image: "mine_icon", selectImage: "mine_icon_highlight", title: "我的", tag: 5)
        
//        self.tabBar.tintColor = UIColor.colorWithRGBHex(hex: 0x000E18)
        self.tabBar.isTranslucent = true
            
        self.viewControllers = [
            QZNavigationController(rootViewController: liftvc),
            QZNavigationController.init(rootViewController: homevc),
            QZNavigationController(rootViewController: publishvc),
            QZNavigationController(rootViewController: topicvc),
            QZNavigationController(rootViewController: minevc),
            
        ]
        self.delegate = self
    }

    
    /**TabBar里面的文字图片**/
    func creatTabBarView(viewController: UIViewController, image:String, selectImage:String, title:String, tag:NSInteger) {
        // alwaysOriginal 始终绘制图片原始状态，不使用Tint Color。
        viewController.tabBarItem.image = UIImage(named: image)?.withRenderingMode(.alwaysOriginal)
        if #available(iOS 13.0, *) {
            let appearance = UITabBarAppearance()
            appearance.shadowImage = UIImage.imageWithColor(color: .clear)
            appearance.configureWithTransparentBackground()
            appearance.stackedLayoutAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor : E18Color,NSAttributedString.Key.font : font11]
            appearance.stackedLayoutAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor : blue226F,NSAttributedString.Key.font : font11]
            
            viewController.tabBarItem.standardAppearance = appearance
        } else {
            viewController.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.red,NSAttributedString.Key.font : UIFont.systemFont(ofSize: 11)], for: .normal)
            viewController.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : blue226F,NSAttributedString.Key.font : UIFont.systemFont(ofSize: 11)], for: .selected)
        }
        
        viewController.tabBarItem.selectedImage = UIImage(named: selectImage)?.withRenderingMode(.alwaysOriginal)
        viewController.title = title
        viewController.tabBarItem.tag = tag
    }
}

    

extension QZBaseTabBarViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if viewController == viewControllers![2] {
           let vc = PublishViewController()
            let nav = BaseNavigationController(rootViewController: vc)
            nav.modalPresentationStyle = .fullScreen
            viewController.present(nav, animated: true, completion: nil)
            return false
        }
        
        return true
    }
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        debugPrint(item.tag)
    }
    
}
