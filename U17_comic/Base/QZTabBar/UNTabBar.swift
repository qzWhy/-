//
//  UNTabBar.swift
//  Owner
//
//  Created by 中时通 on 2022/1/26.
//  Copyright © 2022 轻舟. All rights reserved.
//

import UIKit

class UNTabBar: UITabBar {

    /**懒加载中间按钮**/
    lazy var plusButton: UIButton = {
        let plusBtn = UIButton()
        plusBtn.z_size = CGSize(width: 58, height: 58)
        plusBtn.setImage(UIImage(named: "sendGoods"), for: .normal)
        return plusBtn
    }()
    let tabbarHeight = SystemUtils.getTabBarHeight()
    
    lazy var bgimgView:UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: tabbarHeight))
        imageView.image = UIImage(named: "tabbar_bg")
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        if #available(iOS 13.0, *) {
            let tabbarline = UITabBarAppearance()
            self.standardAppearance = tabbarline
        } else {
            self.backgroundImage = UIImage()
            self.shadowImage = UIImage()
        }
        self.addSubview(bgimgView)
        self.addSubview(plusButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
        debugPrint(subviews)
        //设置中间的按钮的位置
        let x = self.frame.width * 0.5
        let y = self.frame.height * 0.2
        self.plusButton.center = CGPoint(x: x, y: y)
        var tabbarArr: [UIView] = []
        for button in subviews {
            if button.isKind(of: NSClassFromString("UITabBarButton")!) {
                tabbarArr.append(button)
            }
        }
        for i in 0..<tabbarArr.count {
                let btn = tabbarArr[i]
            btn.z_top = 9
        }
    }
    
}
