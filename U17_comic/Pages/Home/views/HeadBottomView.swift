//
//  HeadBottomView.swift
//  dctt_qz
//
//  Created by qingzhou on 2022/3/18.
//

import UIKit

class HeadBottomView: UIView {

    var model: HModel? {
        didSet {
            readLabel.text = model?.readCnt
            tagView.text = model?.type
        }
    }
    
    lazy var readLabel: UILabel = {
        let read = UILabel()
        read.text = "阅读68"
        read.textColor = subTitleColor
        read.font = font12
        return read
    }()
    
    lazy var tagView: UILabel = {
        let tag = UILabel()
        tag.text = "新鲜事"
        tag.textColor = .white
        tag.backgroundColor = .orange
        tag.font = font12
        return tag
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        self.addSubview(readLabel)
        self.addSubview(tagView)
        readLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(12)
            make.top.equalToSuperview()
            make.bottom.equalToSuperview().offset(-12)
            make.width.equalTo(50)
        }
        tagView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalTo(readLabel.snp_right).offset(12)
            make.bottom.equalToSuperview().offset(-12)
            make.left.equalTo(readLabel.snp_right).offset(12)
        }
    }

}
