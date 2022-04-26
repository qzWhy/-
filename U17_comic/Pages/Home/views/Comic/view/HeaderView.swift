//
//  HeaderView.swift
//  U17_comic
//
//  Created by qingzhou on 2022/4/18.
//

import UIKit

class HeaderView: UITableViewHeaderFooterView {

    var cycleHeight:CGFloat = 0 {
        didSet {
            cycleScrollView.snp.remakeConstraints { make in
                make.top.equalToSuperview()
                make.left.right.equalToSuperview()
                make.height.equalTo(cycleHeight)
            }
        }
    }
    
    var title:String? {
        didSet {
            self.titleLabel.text = title
        }
    }
    
    var model: ComicModel? {
        didSet {
            let arr: [galleryItemModel] = model?.galleryItems ?? []
            var imgs: [String] = []
            for item in arr {
                let img = item.topCover ?? ""
                if img == "" {
                    imgs.append(item.cover ?? "")
                } else {
                    imgs.append(item.topCover ?? "")
                }
            }
            self.cycleScrollView.imageURLStringsGroup = imgs
            
        }
    }
    
    lazy var cycleScrollView: SDCycleScrollView = {
        let scrollview = SDCycleScrollView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 500), delegate: self, placeholderImage: UIImage(named: "commondefaultImage"))
        scrollview?.autoScrollTimeInterval = 5
        
        return scrollview!
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "入坑只需一秒"
        label.textColor = titleColor
        label.font = boldFont18
        return label
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        self.addSubview(self.cycleScrollView)
        self.addSubview(self.titleLabel)
        
        cycleScrollView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(500)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.top.equalTo(cycleScrollView.snp_bottom).offset(20)
            make.height.equalTo(20)
            make.right.equalToSuperview().offset(-16)
        }
    }
}

extension HeaderView: SDCycleScrollViewDelegate {}
