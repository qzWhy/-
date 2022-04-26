//
//  AdTableviewCell.swift
//  U17_comic
//
//  Created by qingzhou on 2022/4/15.
//

import UIKit
import Kingfisher
import HandyJSON
class AdTableviewCell: UITableViewCell {

    var model: moduleModel? {
        didSet {
            let arr = model?.items as! [Any]
            
//            let arr = model.items! as! [Any]
            var items:[itemModel1] = []
            for model1 in arr {
                let mm = model1 as! [String : Any]
                let item = JSONDeserializer<itemModel1>.self.deserializeFrom(dict: mm)
                items.append(item!)
            }
//
            self.bgImgView.kf.setImage(with: URL(string: (items[0].cover)!), placeholder: placeholder)
        }
    }
    
    lazy var bgImgView: UIImageView = {
        let imgView = UIImageView()
        imgView.layer.cornerRadius = 5
        imgView.layer.masksToBounds = true
        return imgView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        self.contentView.addSubview(self.bgImgView)
        
        bgImgView.snp.makeConstraints { make in
            make.top.equalTo(self.contentView).offset(20)
            make.left.equalTo(self.contentView).offset(10)
            make.right.equalTo(self.contentView).offset(-10)
            make.height.equalTo(160)
            make.bottom.equalTo(self.contentView).offset(-20)
        }
    }

}
