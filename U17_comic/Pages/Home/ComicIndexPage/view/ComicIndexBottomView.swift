//
//  ComicIndexBottomView.swift
//  U17_comic
//
//  Created by qingzhou on 2022/4/22.
//

import UIKit

class ComicIndexBottomView: UIView {

    var startReadAction:(()->())?
    
    let bWidth: CGFloat = (screenWidth * 0.55 - 80) / 3
    
    lazy var giveMoneyBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("打赏", for: .normal)
        btn.setTitleColor(UIColor.colorWithRGBHex(hex: 0x999999), for: .normal)
        btn.titleLabel?.font = font12
        return btn
    }()
    
    lazy var commentBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("评论", for: .normal)
        btn.setTitleColor(UIColor.colorWithRGBHex(hex: 0x999999), for: .normal)
        btn.titleLabel?.font = font12
        return btn
    }()
    lazy var collectionBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("收藏", for: .normal)
        btn.setTitleColor(UIColor.colorWithRGBHex(hex: 0x999999), for: .normal)
        btn.titleLabel?.font = font12
        return btn
    }()
    lazy var readBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("阅读 第423话", for: .normal)
        btn.setTitleColor( .white, for: .normal)
        btn.backgroundColor = #colorLiteral(red: 0.3283237219, green: 0.8618691564, blue: 0.5440847278, alpha: 1)
        btn.titleLabel?.font = font12
        btn.addTarget(self, action: #selector(startReadBtnClick), for: .touchUpInside)
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        self.addSubview(self.giveMoneyBtn)
        self.addSubview(self.commentBtn)
        self.addSubview(self.collectionBtn)
        self.addSubview(self.readBtn)
        
        giveMoneyBtn.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.left.equalToSuperview().offset(20)
            make.width.equalTo(bWidth)
            make.bottom.equalToSuperview().offset(-5)
        }
        commentBtn.snp.makeConstraints { make in
            make.left.equalTo(giveMoneyBtn.snp_right).offset(20)
            make.top.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().offset(-5)
            make.width.equalTo(bWidth)
        }
        collectionBtn.snp.makeConstraints { make in
            make.left.equalTo(commentBtn.snp_right).offset(20)
            make.top.equalToSuperview().offset(5)
            make.bottom.equalToSuperview().offset(-5)
            make.width.equalTo(bWidth)
        }
        
        readBtn.snp.makeConstraints { make in
            make.left.equalTo(collectionBtn.snp_right).offset(20)
            make.top.bottom.equalToSuperview()
            make.right.equalToSuperview()
        }
    }
    @objc func startReadBtnClick() {
        if let temp = startReadAction {
            temp()
        }
    }

}
