//
//  BaseNavigationController.swift
//  baseDemo
//
//  Created by qingzhou on 2021/9/18.
//

import UIKit

let titleColor = UIColor.colorWithRGBHex(hex: 0x000E18)

class BaseNavigationController: UINavigationController {

    var img: UIImage?
    var backButton: UIBarButtonItem?
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        
        let navBar = UINavigationBar.appearance(whenContainedInInstancesOf: [BaseNavigationController.self])
        
        let attrs = NSMutableDictionary.init()
        attrs[NSAttributedString.Key.foregroundColor] = E18Color
        attrs[NSAttributedString.Key.font] = UIFont.systemFont(ofSize: 18, weight: .medium)
        navBar.titleTextAttributes = attrs as? [NSAttributedString.Key : Any]
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithDefaultBackground()
            appearance.backgroundImage = UIImage()
            appearance.shadowImage = UIImage()
            appearance.shadowColor = .clear
//            appearance.backgroundColor = UIColor.colorWithRGBHex(hex: 0xF3595A)
            appearance.backgroundColor = .white
            appearance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: E18Color]
            
            appearance.titleTextAttributes = attrs as! [NSAttributedString.Key : Any]

            navBar.tintColor = E18Color
            
            // UINavigationBarAppearance 会覆盖原有的导航栏设置，这里需要重新设置返回按钮隐藏
            appearance.backButtonAppearance.normal.titlePositionAdjustment = UIOffset(horizontal: -1000,vertical: 0);
            navBar.standardAppearance = appearance
            navBar.scrollEdgeAppearance = appearance
            navBar.compactAppearance = appearance
        } else {
            navBar.tintColor = UIColor.white
            navBar.barTintColor = UIColor.colorWithRGBHex(hex: 0xF3595A)
            navBar.titleTextAttributes = (attrs as! [NSAttributedString.Key : Any])
        }
        navBar.isTranslucent = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        
        UIApplication.shared.beginReceivingRemoteControlEvents();
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated);
        
        UIApplication.shared.endReceivingRemoteControlEvents();
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        if (self.viewControllers.count > 0) {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated);
        
        if self.viewControllers.count > 1 {
            let vc = self.viewControllers[self.viewControllers.count - 1]
            vc.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "project_back"), style: .plain, target: self, action: #selector(backClick))
        }
    }
    @objc func backClick(){
        self.popViewController(animated: true)
    }
    override var childForStatusBarStyle: UIViewController? {
        return topViewController
    }
}

extension BaseNavigationController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if viewController.isKind(of: MineViewController.self) || viewController.isKind(of: HomeViewController.self) 
        {
            navigationController.setNavigationBarHidden(true, animated: true)
        } else {
            navigationController.setNavigationBarHidden(false, animated: false)
        }
    }
}
