//
//  BookSheetViewCell.swift
//  U17_comic
//
//  Created by qingzhou on 2022/4/25.
//

import UIKit

class BookSheetViewCell: UITableViewCell {

    lazy var imgView: UIImageView = {
        let imgview = UIImageView()
        imgview.backgroundColor = .red
        imgview.layer.cornerRadius = 6
        imgview.layer.masksToBounds = true
        return imgview
    }()
    lazy var titlelabel: UILabel = {
        let label = UILabel()
        label.text = "神之一脚"
        label.textColor = titleColor
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    lazy var sublabel: UILabel = {
        let label = UILabel()
        label.text = "最后阅读-第一话"
        label.textColor = FA3Color
        label.font = font12
        return label
    }()
    lazy var taillabel: UILabel = {
        let label = UILabel()
        label.text = "1话/356话｜1.71MB"
        label.textColor = FA3Color
        label.font = font12
        return label
    }()
    
    lazy var continueBtn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = FA3Color
        btn.layer.cornerRadius = 15
        btn.layer.masksToBounds = true
        btn.titleLabel?.font = font14
        btn.setTitle("继续阅读", for: .normal)
        btn.setTitleColor(UIColor.green, for: .normal)
        return btn
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        self.contentView.addSubview(imgView)
        self.contentView.addSubview(titlelabel)
        self.contentView.addSubview(sublabel)
        self.contentView.addSubview(taillabel)
        self.contentView.addSubview(continueBtn)
        imgView.snp.makeConstraints { make in
            make.top.equalTo(self.contentView)
            .offset(10)
            make.left.equalTo(self.contentView).offset(10)
            make.width.equalTo(120)
            make.height.equalTo(160)
            make.bottom.equalToSuperview().offset(-10)
        }
        titlelabel.snp.makeConstraints { make in
            make.top.equalTo(self.contentView).offset(20)
            make.left.equalTo(imgView.snp_right).offset(10)
            make.height.equalTo(25)
            make.width.equalTo(100)
        }
        sublabel.snp.makeConstraints { make in
            make.left.equalTo(titlelabel.snp_left)
            make.top.equalTo(titlelabel.snp_bottom).offset(15)
            make.height.equalTo(12)
            make.width.equalTo(100)
        }
        taillabel.snp.makeConstraints { make in
            make.left.equalTo(titlelabel.snp_left)
            make.bottom.equalTo(self.contentView).offset(-20)
            make.height.equalTo(12)
            make.width.equalTo(120)
        }
        
        continueBtn.snp.makeConstraints { make in
            make.centerY.equalTo(imgView)
            make.right.equalTo(self.contentView.snp_right).offset(-20)
            make.width.equalTo(75)
            make.height.equalTo(30)
        }
    }

}
