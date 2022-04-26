//
//  ChapterNumbCell.swift
//  U17_comic
//
//  Created by qingzhou on 2022/4/25.
//

import UIKit

class ChapterNumbCell: UICollectionViewCell {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "01"
        
        label.textAlignment = .center
        label.textColor = titleColor
        label.font = boldFont14
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.layer.cornerRadius = 6
        self.contentView.layer.masksToBounds = true
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        self.contentView.backgroundColor = .white
        self.contentView.addSubview(self.titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
