//
//  ComicDetailImgCell.swift
//  U17_comic
//
//  Created by qingzhou on 2022/4/24.
//

import UIKit
import Kingfisher

class ComicDetailImgCell: UICollectionViewCell {
    
    var model: imgModel? {
        didSet {
            guard let model = model else { return }
            imageView.image = nil
            imageView.kf.setImage(with: URL(string: model.location ?? ""), placeholder: placeholder)
        }
    }
    
    lazy var imageView: UIImageView = {
        let iw = UIImageView()
        iw.contentMode = .scaleAspectFit
        return iw
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        self.contentView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
