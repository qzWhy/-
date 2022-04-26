//
//  ComicAdCollectionView.swift
//  U17_comic
//
//  Created by qingzhou on 2022/4/18.
//  moduleType 2 uiType 4

import UIKit

class ComicAdCollectionView: UICollectionViewCell {
    
    var model: itemModel1? {
        didSet {
            self.bgImgView.kf.setImage(with: URL(string: model?.cover ?? ""), placeholder: placeholder)
        }
    }
    
    lazy var bgImgView: UIImageView = {
        let img = UIImageView()
        img.layer.cornerRadius = 10
        img.layer.masksToBounds = true
        return img
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        self.contentView.addSubview(self.bgImgView)
        
        bgImgView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.height.equalTo(250)
        }
    }
    
}
