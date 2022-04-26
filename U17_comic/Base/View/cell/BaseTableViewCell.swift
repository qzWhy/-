//
//  BaseTableViewCell.swift
//  U17_comic
//
//  Created by qingzhou on 2022/4/19.
//

import UIKit

class BaseTableViewCell: UITableViewCell {

    var itemDidClickBlock:((_ index: Int)->())?
    
    lazy var collectionView:UICollectionView = {
        
        let layout : UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 250), collectionViewLayout: layout)
        collection.register(ComicCollectionHorizontalViewCell.self, forCellWithReuseIdentifier: "ComicCollectionHorizontalViewCell")

        collection.register(ComicCollectionViewCell.self, forCellWithReuseIdentifier: "ComicCollectionViewCell")
        collection.delegate = self
        collection.dataSource = self
        return collection
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func creatUI() {
        
    }

}

extension BaseTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ComicCollectionHorizontalViewCell", for: indexPath) as! ComicCollectionHorizontalViewCell
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let dwidth1 = (screenWidth - 30) / 3
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
        
        if let temp = itemDidClickBlock {
            temp(indexPath.row)
        }
        
    }
}
