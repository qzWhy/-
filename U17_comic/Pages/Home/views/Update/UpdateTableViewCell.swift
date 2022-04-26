//
//  UpdateTableViewCell.swift
//  U17_comic
//
//  Created by qingzhou on 2022/4/14.
//

import UIKit
import Kingfisher

class UpdateTableViewCell: UITableViewCell {

    var model: InfoModel? {
        didSet {
            self.imgView.kf.setImage(with: URL(string: model!.cover), placeholder: UIImage(named: "commondefaultImage"))
            self.titleLabel.text = model?.title
            self.tags.text = model?.tagList[0].tagStr
            
            let color:String = (model?.tagList[0].tagColor)!
            
            self.tags.backgroundColor = UIColor.colorWithHexString(hexString: color)
            self.subtitleLabel.text = "更新至  \(model?.description ?? "")"
        }
    }
    
    lazy var imgView:UIImageView = {
        let imgview = UIImageView()
        imgview.layer.cornerRadius = 10
        imgview.layer.masksToBounds = true
        return imgview
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "绝世武神"
        label.textColor = E18Color
        label.font = boldFont16
        return label
    }()
    
    lazy var tags:UILabel = {
        let label1 = UILabel()
        label1.text = "  魔幻  "
        label1.textColor = .white
        label1.textAlignment = .center
        label1.layer.cornerRadius = 9
        label1.layer.masksToBounds = true
        label1.backgroundColor = UIColor.colorWithRGBHex(hex: 0x689BD3)
        label1.font = font12
        return label1
    }()
    
    lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "更新至  师兄妹"
        label.textColor = subTitleColor
        label.font = font14
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        self.contentView.addSubview(self.imgView)
        self.contentView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.tags)
        self.contentView.addSubview(self.subtitleLabel)
        
        let line = UIView()
        line.backgroundColor = bgColor
        self.contentView.addSubview(line)
        
        imgView.snp.makeConstraints { make in
            make.top.equalTo(self.contentView).offset(20)
            make.left.equalTo(self.contentView).offset(10)
            make.right.equalTo(self.contentView).offset(-10)
            make.height.equalTo(200)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imgView.snp_bottom).offset(10)
            make.left.equalTo(self.contentView).offset(10)
            make.height.equalTo(20)
        }
        tags.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel)
            make.width.equalTo(40)
            make.left.equalTo(titleLabel.snp.right).offset(5)
            make.height.equalTo(18)
        }
        subtitleLabel.snp.makeConstraints { make in
            make.left.equalTo(titleLabel.snp_left)
            make.top.equalTo(titleLabel.snp_bottom).offset(10)
            make.height.equalTo(16)
            make.right.equalTo(self.contentView).offset(-20)
        }
        line.snp.makeConstraints { make in
            make.top.equalTo(subtitleLabel.snp_bottom).offset(20)
            make.height.equalTo(10)
            make.left.right.equalTo(self.contentView)
            make.bottom.equalTo(self.contentView.snp_bottom)
        }
    }

}
