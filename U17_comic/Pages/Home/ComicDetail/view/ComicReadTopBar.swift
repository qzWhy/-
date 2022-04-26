//
//  ComicReadTopBar.swift
//  U17_comic
//
//  Created by qingzhou on 2022/4/24.
//

import UIKit

class ComicReadTopBar: UIView {

    var backBtnBlock:(()->())?
    var btnClickBlock:((_ index: Int)->())?
    lazy var backBtn: UIButton = {
        let bn = UIButton()
        bn.setImage(UIImage(named: "nav_back_black"), for: .normal)
        bn.addTarget(self, action: #selector(backBtnClick), for: .touchUpInside)
        bn.setTitleColor(.red, for: .normal)
        return bn
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "02 第一张 学院（一）"
        label.textColor = .white
        label.font = boldFont18
        return label
    }()
    lazy var moreBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "more"), for: .normal)
        btn.tag = 100
        btn.addTarget(self, action: #selector(btnClick(sender:)), for: .touchUpInside)
        return btn
    }()
    lazy var shotBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "shotscreen"), for: .normal)
        btn.tag = 101
        btn.addTarget(self, action: #selector(btnClick(sender:)), for: .touchUpInside)
        return btn
    }()
    lazy var download: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "download"), for: .normal)
        btn.tag = 102
        btn.addTarget(self, action: #selector(btnClick(sender:)), for: .touchUpInside)
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.init(white: 0, alpha: 0.4)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        
        addSubview(backBtn)
        addSubview(titleLabel)
        addSubview(moreBtn)
        addSubview(shotBtn)
        addSubview(download)
        backBtn.snp.makeConstraints { make in
            
            make.width.height.equalTo(40)
            make.left.equalToSuperview()
            make.centerY.equalTo(titleLabel)
        }
        titleLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: SystemUtils.getStatusHeight(), left: 50, bottom: 0, right: 50))
        }
        moreBtn.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel)
            make.right.equalToSuperview().offset(-10)
            make.width.height.equalTo(30)
        }
        shotBtn.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel)
            make.right.equalTo(moreBtn.snp_left).offset(-10)
            make.width.height.equalTo(30)
        }
        download.snp.makeConstraints { make in
            make.centerY.equalTo(titleLabel)
            make.right.equalTo(shotBtn.snp_left).offset(-10)
            make.width.height.equalTo(30)
        }
    }
    
    @objc func backBtnClick() {
        if let temp = backBtnBlock {
            temp()
        }
    }
    @objc func btnClick(sender: UIButton) {
        debugPrint(sender.tag)
        let tag = sender.tag
        if let temp = btnClickBlock {
            temp(tag)
        }
    }
    
}
