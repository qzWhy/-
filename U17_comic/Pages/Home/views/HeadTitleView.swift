//
//  HeadTitleView.swift
//  dctt_qz
//
//  Created by qingzhou on 2022/3/18.
//  头像 + 昵称 + 时间

import UIKit

class HeadTitleView: UIView {
    
    
    var user:QUser? {
        didSet {
            self.nickLabel.text = user?.nickName
            self.timeLabel.text = user?.last_login_time
//            headerIcon.kf.setImage(urlString: user?.avatar)
            let url = URL(string: user!.avatar)
            headerIcon.kf.setImage(with: url, placeholder: UIImage(named: "avatar_default"))
        }
    }
    
    lazy var headerIcon: UIImageView = {
        let heade = UIImageView()
        heade.image = UIImage(named: "avatar_default")
        heade.layer.cornerRadius = 17
        heade.layer.masksToBounds = true
        return heade
    }()

    lazy var nickLabel: UILabel = {
        let nick = UILabel()
        nick.text = "青春不老"
        nick.textColor = titleColor
        nick.font = font14
        return nick
    }()
    
    lazy var timeLabel: UILabel = {
        let time = UILabel()
        time.text = "2022-01-16"
        time.textColor = subTitleColor
        time.font = font12
        return time
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        self.addSubview(self.headerIcon)
        self.addSubview(nickLabel)
        self.addSubview(timeLabel)
        headerIcon.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(12)
            make.top.equalToSuperview().offset(12)
            make.width.height.equalTo(34)
        }
        nickLabel.snp.makeConstraints { make in
            make.left.equalTo(headerIcon.snp_right).offset(12)
            make.top.equalTo(headerIcon.snp_top)
            make.right.equalToSuperview().offset(-12)
            make.height.equalTo(14)
        }
        timeLabel.snp.makeConstraints { make in
            make.bottom.equalTo(headerIcon.snp_bottom)
            make.left.equalTo(nickLabel.snp_left)
            make.right.equalTo(nickLabel.snp_right)
            make.height.equalTo(12)
        }
    }

}
