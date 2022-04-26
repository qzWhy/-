//
//  TableHeaderTitleView.swift
//  U17_comic
//
//  Created by qingzhou on 2022/4/18.
//

import UIKit

class TableHeaderTitleView: UITableViewHeaderFooterView {

    var title:String? {
        didSet {
            self.titleLabel.text = title
        }
    }
    
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
        self.contentView.addSubview(self.titleLabel)
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(20)
            make.height.equalTo(20)
            make.right.equalToSuperview().offset(-16)
        }
    }

}
