# 有妖气动漫

#### 介绍
手动仿写有妖气漫画2022年4月开始，仅为学习用，如有侵权，请联系删除

### 图片


#### 软件架构
软件架构说明



#### 安装教程

1.  xxxx
2.  xxxx
3.  xxxx

#### 使用说明

1.  xxxx
2.  xxxx
3.  xxxx

#### 参与贡献

1.  Fork 本仓库
2.  新建 Feat_xxx 分支
3.  提交代码
4.  新建 Pull Request


#### 特技
1.  swift滑动特效可查看动漫介绍页


#### bug
1. 当移动info.plist位置时会报错：Build input file cannot be found: '/Users/yst/Documents/XXX/Info.plist'
    方案： build Setting里搜索info 在info.plist File设置路径$(SRCROOT)+路径
    其中$(SRCROOT)是相对路径
2. 在开发过程中也许会遇到图片加载不出来的问题(SDCycleScrollView加载网路图片会无法加载,但是在浏览器上正常)
    ```
        swift  since it does not conform to ATS policy  
    ```
    这时只需设置
    App Transport Security Settings 
    Allow Arbitrary Loads
3. 
    给textview设置行高 添加以下：
    ```
            let paraph = NSMutableParagraphStyle()
        //行间距
        paraph.lineSpacing = 5
        //样式属性集合
        label.typingAttributes[NSAttributedString.Key(rawValue: NSAttributedString.Key.font.rawValue)] = font12
        label.typingAttributes[NSAttributedString.Key(rawValue: NSAttributedString.Key.paragraphStyle.rawValue)] = paraph
        label.typingAttributes[NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue)] =  #colorLiteral(red: 0.6666000485, green: 0.6667006016, blue: 0.6665862203, alpha: 1)
    ```
