//
//  QZTabBar.swift
//  Owner
//
//  Created by 轻舟 on 2022/1/18.
//  Copyright © 2022 中时通. All rights reserved.
//

import UIKit

/**声明一个协议clcikDelegate，需要继承NSObjectProtocol**/
protocol QZTabBarDelegate: NSObjectProtocol {
    func tabBarDidClickPlusButton()
}

/**定义必包类型（block）**/
typealias dateBlok = (String)->()
typealias dictBlock = (NSMutableDictionary)->()

class QZTabBar: UITabBar {

    /**声明代理**/
    weak var myDelegate: QZTabBarDelegate?
    
    /**声明一个block变量**/
    var datePickBlock: dateBlok?
    var dictDataBlock: dictBlock?
    
    /**懒加载中间按钮**/
    lazy var plusButton: UIButton = {
        let plusBtn = UIButton()
        plusBtn.setImage(UIImage(named: "sendGoods"), for: .normal)
        plusBtn.setImage(UIImage(named: "sendGoods"), for: .highlighted)
        plusBtn.titleLabel?.font = font11
        plusBtn.setTitleColor(blue226F, for: .selected)
        plusBtn.setTitle("发布", for: .normal)
        plusBtn.setTitleColor(E18Color, for: .normal)
        
        let buttonImg: UIImage? = plusBtn.image(for: .normal)
        
        // 暂时没有找到计算字符串长度的方法
//        var titleWidth: CGFloat? = NSString(string: plusButton.titleLabel?.text).size(attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: 18)]).width
//        let titleWidth = self
        plusBtn.titleEdgeInsets = UIEdgeInsets.init(top: buttonImg!.size.height + 5, left: -buttonImg!.size.height, bottom: -5, right: 0)
        plusBtn.imageEdgeInsets = UIEdgeInsets(top: -5, left: 0, bottom: 0, right: -20)
        
        plusBtn.frame = CGRect(x: 0, y: 0, width: plusBtn.imageView!.image!.size.width, height: plusBtn.imageView!.image!.size.height + 20)
        plusBtn.addTarget(self, action: #selector(QZTabBar.respondsToPlusButton), for: .touchUpInside)
        return plusBtn
    }()
    
    lazy var bgimgView:UIImageView = {
        let imageView = UIImageView(frame: self.bounds)
//        imageView.image = UIImage(named: "tabbar_bg")
        imageView.image = UIImage.imageWithColor(color: UIColor.white)
        return imageView
    }()

    //MARK: - QZTabBarDelegate
    @objc func respondsToPlusButton() {
        //和oc不一样的是，Swift中如果简单的调用代理方法，不能用判断代理能否响应
        self.plusButton.isSelected = true
        if let temp = myDelegate {
            temp.tabBarDidClickPlusButton()
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(bgimgView)
//        self.addSubview(self.plusButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    //重新布局
    override func layoutSubviews() {
        super.layoutSubviews()
        
        //block 传递
        var dict: NSMutableDictionary!
        dict = [
            "name":"hzl"
        ]
        if let temp = datePickBlock {
            temp("参数")
        }
        if let temp1 = dictDataBlock {
            temp1(dict)
        }
        
        
        //设置中间的按钮的位置
//        let x = self.frame.width * 0.5
//        let y = self.frame.height * 0.2
//        self.plusButton.center = CGPoint(x: x, y: y)
//        self.plusButton.z_centerX = x
//        self.plusButton.z_centerY =
        self.bgimgView.frame = self.bounds
        let w = self.frame.width / 4
        var index = 0
        for childView: UIView in self.subviews {
            if childView.isKind(of: NSClassFromString("UITabBarButton")!) {
                let isIphoneX: Bool = SystemUtils.isIphoneX()
                if isIphoneX {
                    childView.frame = CGRect(x: w * CGFloat(index), y: 9, width: w, height: self.frame.size.height - 34)
                } else {
                    childView.frame = CGRect(x: w * CGFloat(index), y: 9, width: w, height: self.frame.size.height)
                }
                
                index+=1
                
//                if index == 2 {
//                    index+=1
//                }
            }
        }
    }
    
    // MARK: - 重写hitTest方法，监听按钮的点击 让凸出tabbar的部分响应点击
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        //判断是否为根控制器
        if self.isHidden {
            //tabbar隐藏 不在主页 系统处理
            return super.hitTest(point, with: event)
        } else {
            //将单线触摸点转换到按钮上生成新的点
            let onButton = self.convert(point, to: self.plusButton)
            //判断新的点是否在按钮上
            if self.plusButton.point(inside: onButton, with: event) {
                return plusButton
            } else {
                //不在按钮上 系统处理
                return super.hitTest(point, with: event)
            }
        }
    }
}
