//
//  HomeListTableViewCell.swift
//  dctt_qz
//
//  Created by qingzhou on 2022/3/18.
//

import UIKit

class HomeListTableViewCell: UITableViewCell {

    var model:HModel? {
        didSet {
            self.contentLabel.text = model?.content
            headview.user = model?.user
            btmview.model = model
        }
    }
    
    lazy var headview: HeadTitleView = {
        let head = HeadTitleView()
        return head
    }()
    
    lazy var contentLabel: UILabel = {
        let content = UILabel()
        content.text = ""
        content.font = font14
        content.numberOfLines = 3
        content.textColor = titleColor
        return content
    }()
    
    lazy var imgView: HomeImgView = {
        let imgVi = HomeImgView()
        return imgVi
    }()
    
    lazy var btmview: HeadBottomView = {
        let btm = HeadBottomView()
        
        return btm
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        self.contentView.addSubview(headview);
        self.contentView.addSubview(contentLabel)
        self.contentView.addSubview(imgView)
        self.contentView.addSubview(btmview)
        
        let line = UIView()
        line.backgroundColor = lineColor
        self.contentView.addSubview(line)
        
        headview.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(60)
            
        }
        
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(headview.snp_bottom)
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
//            make.bottom.equalTo(line.snp_top)
        }
        imgView.snp.makeConstraints { make in
            make.left.top.right.equalTo(self.contentView)
            make.height.equalTo(30)
        }
        
        btmview.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(contentLabel.snp_bottom).offset(12)
            make.bottom.equalTo(line.snp_top)
        }
        
        line.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
            make.bottom.equalToSuperview().offset(-1)
            make.height.equalTo(1)
        }
    }

}
