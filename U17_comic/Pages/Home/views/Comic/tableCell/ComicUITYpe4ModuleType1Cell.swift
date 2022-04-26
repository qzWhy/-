//
//  ComicUITYpe4ModuleType1Cell.swift
//  U17_comic
//
//  Created by qingzhou on 2022/4/18.
//

import UIKit

class ComicUITYpe4ModuleType1Cell: UITableViewCell {

    var itemArr: [itemModel]? {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    lazy var collectionView:UICollectionView = {
        
        let layout : UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 400), collectionViewLayout: layout)
        collection.register(ComicCollectionHorizontalViewCell.self, forCellWithReuseIdentifier: "ComicCollectionHorizontalViewCell")
        collection.isScrollEnabled = false
        collection.delegate = self
        collection.dataSource = self
        return collection
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        self.contentView.addSubview(self.collectionView)
        self.collectionView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(470)
        }
    }

}

extension ComicUITYpe4ModuleType1Cell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemArr?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ComicCollectionHorizontalViewCell", for: indexPath) as! ComicCollectionHorizontalViewCell
        cell.model = itemArr![indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let dwidth = (screenWidth - 30)/3
        if indexPath.row == 0 {
            return CGSize.init(width: dwidth*2, height: 230)
        }
        let dwidth1 = (screenWidth - 40)/3
        return CGSize.init(width: dwidth1, height: 230)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 6
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        
    }
}
