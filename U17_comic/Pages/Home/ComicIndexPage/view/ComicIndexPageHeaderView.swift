//
//  ComicIndexPageHeaderView.swift
//  U17_comic
//
//  Created by qingzhou on 2022/4/20.
//

import UIKit

class ComicIndexPageHeaderView: UIView {

    var model:comicModel1? {
        didSet {
            self.comicCoverImg.kf.setImage(with: URL(string: model?.cover ?? ""), placeholder: placeholder)
            self.comicNameLabel.text = model?.name ?? ""
            self.authorLabel.text = model?.author?.name
            hotlabel.text = "热度值 \(model?.click_total ?? "0")"
            collectionlabel.text = "收藏值 \(model?.favorite_total ?? "0")"
        }
    }
    
    lazy var comicCoverImg: UIImageView = {
        let img = UIImageView()
        img.layer.cornerRadius = 10
        img.layer.borderWidth = 3
        img.layer.borderColor = UIColor.white.cgColor
        img.clipsToBounds = true
        return img
    }()
    
    lazy var comicNameLabel: UILabel = {
        let label = UILabel()
        label.text = "端脑"
        label.textColor = .white
        label.font = boldFont16
        return label
    }()
    
    lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.text = "壁水羽"
        label.textColor = .white
        label.font = font14
        return label
    }()
    
    lazy var bottom: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        view.layer.masksToBounds = true
        view.backgroundColor = .white
        return view
    }()
    
    lazy var hotImg: UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "")
        return img
    }()
    
    lazy var hotlabel: UILabel = {
        let hot = UILabel()
        hot.text = "热度值:"
        hot.textColor = UIColor.colorWithRGBHex(hex: 0xBEBFC0)
        hot.font = font14
        return hot
    }()
    lazy var collectionlabel: UILabel = {
        let hot = UILabel()
        hot.text = "收藏值:"
        hot.textColor = UIColor.colorWithRGBHex(hex: 0xBEBFC0)
        hot.font = font14
        return hot
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        self.backgroundColor = .clear
        self.addSubview(self.bottom)
        self.addSubview(self.comicCoverImg)
        self.addSubview(self.comicNameLabel)
        self.addSubview(authorLabel)
        self.bottom.addSubview(self.hotlabel)
        self.bottom.addSubview(self.collectionlabel)
        
        comicCoverImg.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-20)
            make.left.equalToSuperview().offset(20)
            make.width.equalTo(140)
            make.height.equalTo(180)
        }
        comicNameLabel.snp.makeConstraints { make in
            make.top.equalTo(comicCoverImg.snp_top).offset(10)
            make.left.equalTo(comicCoverImg.snp_right).offset(10)
            make.height.equalTo(20)
        }
        authorLabel.snp.makeConstraints { make in
            make.left.equalTo(comicNameLabel.snp.left)
            make.right.equalTo(200)
            make.height.equalTo(14)
            make.top.equalTo(comicNameLabel.snp_bottom).offset(30)
        }
        bottom.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.height.equalTo(80)
            make.bottom.equalToSuperview()
        }
        
        hotlabel.snp.makeConstraints { make in
            make.left.equalTo(authorLabel.snp_left)
            make.top.equalToSuperview().offset(10)
            make.height.equalTo(14)
            make.right.equalToSuperview().offset(-20)
        }
        collectionlabel.snp.makeConstraints { make in
            make.top.equalTo(hotlabel.snp_bottom).offset(10)
            make.left.equalTo(hotlabel.snp_left)
            make.height.equalTo(14)
            make.right.equalToSuperview().offset(-20)
        }
        
    }

}

class ComicIndexPageBgView: UIView {
    
    var model:comicModel1? {
        didSet {
            self.bgImgView.kf.setImage(with: URL(string: model?.wideCover ?? ""), placeholder: placeholder)
            self.coverView.backgroundColor = UIColor.colorWithHexString(hexString: model?.wideColor, alpha: 0.4)
        }
    }
    
    /**添加高斯模糊**/
    lazy var blurEffect: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let blur = UIBlurEffect(style: .dark)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.alpha = 0.4
        return blurView
    }()
    
    lazy var bgImgView: UIImageView = {
        let img = UIImageView()
        return img
    }()
    
    lazy var coverView: UIView = {
        let cover = UIView()
        return cover
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        self.backgroundColor = .white
        self.addSubview(self.bgImgView)
        self.bgImgView.addSubview(self.blurEffect)
        self.bgImgView.addSubview(self.coverView)
        
        bgImgView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(180 + SystemUtils.getStatusHeight() + SystemUtils.getNavHeight() + 20)
        }
        coverView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        blurEffect.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.height.equalTo(180 + SystemUtils.getNavHeight() + SystemUtils.getStatusHeight())
        }
    }
}
