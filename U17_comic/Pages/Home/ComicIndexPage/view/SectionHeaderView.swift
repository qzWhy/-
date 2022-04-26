//
//  SectionHeaderView.swift
//  U17_comic
//
//  Created by qingzhou on 2022/4/22.
//

import UIKit

class SectionHeaderView: UIView {

    lazy var titleLabel: UILabel = {
        let title = UILabel()
        title.text = "评论"
        title.textColor = titleColor
        title.font = boldFont18
        return title
    }()
    
    lazy var subLabel:UILabel = {
        let label = UILabel()
        label.text = "(共18.4万条评论)"
        label.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        label.font = font14
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
        self.addSubview(titleLabel)
        self.addSubview(subLabel)
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
            make.height.equalTo(20)
        }
        subLabel.snp.makeConstraints { make in
            make.left.equalTo(titleLabel.snp_right).offset(5)
            make.bottom.equalTo(titleLabel.snp_bottom)
            make.height.equalTo(14)
        }
    }

}
