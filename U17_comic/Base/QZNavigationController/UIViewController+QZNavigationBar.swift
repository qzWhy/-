//
//  UIViewController+QZNavigationBar.swift
//  U17_comic
//
//  Created by qingzhou on 2022/4/20.
//  在扩展中添加属性

import UIKit

// MARK: -  自定义导航栏相关的属性, 支持UINavigationBar.appearance()
extension UIViewController {
    
    // MARK: -  属性
    
    /// keys
    private struct QZNavigationBarKeys {
        static var barStyle = "QZNavigationBarKeys_barStyle"
        static var backgroundColor = "QZNavigationBarKeys_backgroundColor"
        static var backgroundImage = "QZNavigationBarKeys_backgroundImage"
        static var tintColor = "QZNavigationBarKeys_tintColor"
        static var barAlpha = "QZNavigationBarKeys_barAlpha"
        static var titleColor = "QZNavigationBarKeys_titleColor"
        static var titleFont = "QZNavigationBarKeys_titleFont"
        static var shadowHidden = "QZNavigationBarKeys_shadowHidden"
        static var shadowColor = "QZNavigationBarKeys_shadowColor"
        static var enablePopGesture = "QZNavigationBarKeys_enablePopGesture"
    }

    /// 导航栏样式，默认样式
    var qz_barStyle: UIBarStyle {
        get {
            return objc_getAssociatedObject(self, &QZNavigationBarKeys.barStyle) as? UIBarStyle ?? UINavigationBar.appearance().barStyle
        }
        set {
            objc_setAssociatedObject(self, &QZNavigationBarKeys.barStyle, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
            qz_setNeedsNavigationBarTintUpdate()
        }
    }
    
    /// 导航栏前景色（item的文字图标颜色），默认黑色
    var qz_tintColor: UIColor {
        get {
            if let tintColor = objc_getAssociatedObject(self, &QZNavigationBarKeys.tintColor) as? UIColor {
                return tintColor
            }
            if let tintColor = UINavigationBar.appearance().tintColor {
                return tintColor
            }
            return .black
        }
        set {
            objc_setAssociatedObject(self, &QZNavigationBarKeys.tintColor, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            qz_setNeedsNavigationBarTintUpdate()
        }
    }
    
    
    /// 导航栏标题文字颜色，默认黑色
    var qz_titleColor: UIColor {
        get {
            if let titleColor = objc_getAssociatedObject(self, &QZNavigationBarKeys.titleColor) as? UIColor {
                return titleColor
            }
            if let titleColor = UINavigationBar.appearance().titleTextAttributes?[NSAttributedString.Key.foregroundColor] as? UIColor {
                return titleColor
            }
            return .black
        }
        set {
            objc_setAssociatedObject(self, &QZNavigationBarKeys.titleColor, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            qz_setNeedsNavigationBarTintUpdate()
        }
    }
    
    /// 导航栏标题文字字体，默认17号粗体
    var qz_titleFont: UIFont {
        get {
            if let titleFont = objc_getAssociatedObject(self, &QZNavigationBarKeys.titleFont) as? UIFont {
                return titleFont
            }
            if let titleFont = UINavigationBar.appearance().titleTextAttributes?[NSAttributedString.Key.font] as? UIFont {
                return titleFont
            }
            return UIFont.boldSystemFont(ofSize: 17)
        }
        set {
            objc_setAssociatedObject(self, &QZNavigationBarKeys.titleFont, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            qz_setNeedsNavigationBarTintUpdate()
        }
    }
    
    
    /// 导航栏背景色，默认白色
    var qz_backgroundColor: UIColor {
        get {
            if let backgroundColor = objc_getAssociatedObject(self, &QZNavigationBarKeys.backgroundColor) as? UIColor {
                return backgroundColor
            }
            if let backgroundColor = UINavigationBar.appearance().barTintColor {
                return backgroundColor
            }
            return .white
        }
        set {
            objc_setAssociatedObject(self, &QZNavigationBarKeys.backgroundColor, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            qz_setNeedsNavigationBarBackgroundUpdate()
        }
    }
    
    /// 导航栏背景图片
    var qz_backgroundImage: UIImage? {
        get {
            return objc_getAssociatedObject(self, &QZNavigationBarKeys.backgroundImage) as? UIImage ?? UINavigationBar.appearance().backgroundImage(for: .default)
        }
        set {
            objc_setAssociatedObject(self, &QZNavigationBarKeys.backgroundImage, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            qz_setNeedsNavigationBarBackgroundUpdate()
        }
    }
    
    /// 导航栏背景透明度，默认1
    var qz_barAlpha: CGFloat {
        get {
            return objc_getAssociatedObject(self, &QZNavigationBarKeys.barAlpha) as? CGFloat ?? 1
        }
        set {
            objc_setAssociatedObject(self, &QZNavigationBarKeys.barAlpha, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
            qz_setNeedsNavigationBarBackgroundUpdate()
        }
    }

    /// 导航栏底部分割线是否隐藏，默认不隐藏
    var qz_shadowHidden: Bool {
        get {
            return objc_getAssociatedObject(self, &QZNavigationBarKeys.shadowHidden) as? Bool ?? false
        }
        set {
            objc_setAssociatedObject(self, &QZNavigationBarKeys.shadowHidden, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
            qz_setNeedsNavigationBarShadowUpdate()
        }
    }
    
    /// 导航栏底部分割线颜色
    var qz_shadowColor: UIColor {
        get {
            return objc_getAssociatedObject(self, &QZNavigationBarKeys.shadowColor) as? UIColor ?? UIColor(white: 0, alpha: 0.3)
        }
        set {
            objc_setAssociatedObject(self, &QZNavigationBarKeys.shadowColor, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
            qz_setNeedsNavigationBarShadowUpdate()
        }
    }
    
    /// 是否开启手势返回，默认开启
    var qz_enablePopGesture: Bool {
        get {
            return objc_getAssociatedObject(self, &QZNavigationBarKeys.enablePopGesture) as? Bool ?? true
        }
        set {
            objc_setAssociatedObject(self, &QZNavigationBarKeys.enablePopGesture, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }
    
    // MARK: -  更新UI

    // 整体更新
    func qz_setNeedsNavigationBarUpdate() {
        guard let naviController = navigationController as? QZNavigationController else { return }
        naviController.qz_updateNavigationBar(for: self)
    }
    
    // 更新文字、title颜色
    func qz_setNeedsNavigationBarTintUpdate() {
        guard let naviController = navigationController as? QZNavigationController else { return }
        naviController.qz_updateNavigationBarTint(for: self)
    }

    // 更新背景
    func qz_setNeedsNavigationBarBackgroundUpdate() {
        guard let naviController = navigationController as? QZNavigationController else { return }
        naviController.qz_updateNavigationBarBackground(for: self)
    }
    
    // 更新shadow
    func qz_setNeedsNavigationBarShadowUpdate() {
        guard let naviController = navigationController as? QZNavigationController else { return }
        naviController.qz_updateNavigationBarShadow(for: self)
    }
    
}
