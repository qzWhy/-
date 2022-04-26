//
//  ComicVideoCell.swift
//  U17_comic
//
//  Created by qingzhou on 2022/4/18.
//

import UIKit
import Kingfisher
class ComicVideoCell: UICollectionViewCell {
    
    var model: itemModel? {
        didSet {
            self.bgView.kf.setImage(with: URL(string: model?.cover ?? ""), placeholder: placeholder)
            self.titleLabel.text = model?.title
            self.subTitle.text = model?.subTitle
            
        }
    }
    
    lazy var titleLabel:UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = boldFont16
        return label
    }()
    
    lazy var subTitle:UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = font12
        return label
    }()
    
    lazy var bgView: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        
        return view
    }()
    
    lazy var coverView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.colorRGBA(r: 0, g: 0, b: 0, a: 0.5)
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var startBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "startVideo"), for: .normal)
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        self.contentView.addSubview(self.bgView)
        self.bgView.addSubview(self.coverView)
        self.coverView.addSubview(self.startBtn)
        self.coverView.addSubview(subTitle)
        self.coverView.addSubview(titleLabel)
        bgView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        coverView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        startBtn.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(-40)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(30)
        }
        subTitle.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-5)
            make.height.equalTo(16)
        }
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(20)
            make.bottom.equalTo(subTitle.snp_top).offset(-5)
        }
    }
}
