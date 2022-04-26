//
//  CommonHeaderView.swift
//  U17_comic
//
//  Created by qingzhou on 2022/4/22.
//

import UIKit

class CommonHeaderView: UIView {

    lazy var headImgView: UIImageView = {
        let imgview = UIImageView()
        imgview.image = UIImage(named: "")
        imgview.backgroundColor = .random()
        imgview.layer.cornerRadius = 20
        imgview.layer.masksToBounds = true
        return imgview
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "风中新歌"
        label.textColor = titleColor
        label.font = font14
        return label
    }()
    
    lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.text = "01-25  04:05"
        label.textColor = #colorLiteral(red: 0.7371818423, green: 0.7372922301, blue: 0.7371667027, alpha: 1)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        self.addSubview(self.headImgView)
        self.addSubview(self.nameLabel)
        self.addSubview(self.timeLabel)
        headImgView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalToSuperview().offset(10)
            make.width.height.equalTo(40)
        }
        nameLabel.snp.makeConstraints { make in
            make.left.equalTo(headImgView.snp_right).offset(5)
            make.centerY.equalTo(headImgView).offset(-7)
            make.height.equalTo(14)
        }
        timeLabel.snp.makeConstraints { make in
            make.left.equalTo(nameLabel.snp_left)
            make.centerY.equalTo(headImgView).offset(12)
            make.height.equalTo(12)
        }
    }

}
