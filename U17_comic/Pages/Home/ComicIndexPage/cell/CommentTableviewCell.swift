//
//  CommentTableviewCell.swift
//  U17_comic
//
//  Created by qingzhou on 2022/4/22.
//

import UIKit

class CommentTableviewCell: UITableViewCell {

    lazy var headView: CommonHeaderView = {
        let headview = CommonHeaderView()
        
        return headview
    }()
    
    lazy var contenTView: UITextView = {
        let textV = UITextView()
        
        let paraph = NSMutableParagraphStyle()
        //行间距
        paraph.lineSpacing = 5
        //样式属性集合
        textV.typingAttributes[NSAttributedString.Key(rawValue: NSAttributedString.Key.font.rawValue)] = font14
        textV.typingAttributes[NSAttributedString.Key(rawValue: NSAttributedString.Key.paragraphStyle.rawValue)] = paraph
        textV.typingAttributes[NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue)] =  titleColor
        textV.isUserInteractionEnabled = false
        textV.text = "2020年12月10日 单击更新以确保所有应用程序都是最新的 更新完成后,单击“备份” 等待那完成 在这种情况下,请不要退出Apple Configurator 2 相反,转到Finder并按Shift-Command-G或选择“转到”菜.."
        return textV
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        self.contentView.addSubview(self.headView)
        self.contentView.addSubview(self.contenTView)
        headView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(55)
        }
        contenTView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.top.equalTo(headView.snp_bottom).offset(5)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(100)
            make.bottom.equalToSuperview()
        }
    }

}
