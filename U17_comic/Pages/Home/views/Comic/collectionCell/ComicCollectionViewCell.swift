//
//  ComicCollectionViewCell.swift
//  U17_comic
//
//  Created by qingzhou on 2022/4/15.
//

import UIKit
import Kingfisher

class ComicCollectionViewCell: UICollectionViewCell {
    
    var model: itemModel? {
        didSet {
            self.imgView.kf.setImage(with: URL(string: (model?.cover!)!), placeholder: UIImage(named: "commondefaultImage"))
            self.titleLabel.text = model?.title
            self.subtitleLabel.text = model?.subTitle
        }
    }
    
    let dwidth = ((screenWidth - 30) - 10) / 2
    lazy var imgView: UIImageView = {
        let img = UIImageView()
        img.layer.cornerRadius = 8
        img.layer.masksToBounds = true
        return img
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "龙俦纪"
        label.textColor = titleColor
        label.font = font16
        return label
    }()
    
    lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "化龙少女的冒险"
        label.textColor = subTitleColor
        label.font = font14
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        self.contentView.addSubview(self.imgView)
        self.contentView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.subtitleLabel)
        
        imgView.snp.makeConstraints { make in
            make.top.left.right.equalTo(self.contentView)
            make.height.equalTo(100)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imgView.snp_bottom).offset(10)
            make.left.right.equalTo(self.contentView)
            make.height.equalTo(16)
        }
        subtitleLabel.snp.makeConstraints { make in
            make.left.right.equalTo(self.contentView)
            make.top.equalTo(titleLabel.snp_bottom).offset(5)
            make.height.equalTo(14)
        }
    }
    
}

class ComicCollectionHorizontalViewCell: UICollectionViewCell {
    
    var model: itemModel? {
        didSet {
            self.imgView.kf.setImage(with: URL(string: (model?.cover!)!), placeholder: UIImage(named: "commondefaultImage"))
            self.titleLabel.text = model?.title
            self.subtitleLabel.text = model?.subTitle
        }
    }
    
    let dwidth = ((screenWidth - 30) - 10) / 2
    lazy var imgView: UIImageView = {
        let img = UIImageView()
        img.layer.cornerRadius = 8
        img.layer.masksToBounds = true
        return img
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "龙俦纪"
        label.textColor = titleColor
        label.font = font16
        return label
    }()
    
    lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "化龙少女的冒险"
        label.textColor = subTitleColor
        label.font = font14
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        self.contentView.addSubview(self.imgView)
        self.contentView.addSubview(self.titleLabel)
        self.contentView.addSubview(self.subtitleLabel)
        
        imgView.snp.makeConstraints { make in
            make.top.left.right.equalTo(self.contentView)
            make.height.equalTo(180)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imgView.snp_bottom).offset(10)
            make.left.right.equalTo(self.contentView)
            make.height.equalTo(16)
        }
        subtitleLabel.snp.makeConstraints { make in
            make.left.right.equalTo(self.contentView)
            make.top.equalTo(titleLabel.snp_bottom).offset(5)
            make.height.equalTo(14)
        }
    }
    
}

