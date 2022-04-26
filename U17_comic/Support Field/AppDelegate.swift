//
//  AppDelegate.swift
//  U17_comic
//
//  Created by qingzhou on 2022/4/14.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        
        window?.backgroundColor = .white
        
        let tab = QZBaseTabBarViewController()
        tab.selectedIndex = 1
        
        window?.rootViewController = tab
        
        window?.makeKeyAndVisible()
        
        return true
    }

   


}

