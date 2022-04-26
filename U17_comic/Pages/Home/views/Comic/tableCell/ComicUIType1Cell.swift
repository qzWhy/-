//
//  ComicUIType1Cell.swift
//  U17_comic
//
//  Created by qingzhou on 2022/4/15.
//

import UIKit

class ComicUIType1Cell: BaseTableViewCell {

    
    var itemArr: [itemModel]? {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    let dwidth = ((screenWidth - 30) - 10) / 2
    
//    lazy var collectionView:UICollectionView = {
//        
//        let layout : UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
//        
//        let collection = UICollectionView(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 365), collectionViewLayout: layout)
//        collection.isScrollEnabled = false
//        collection.register(ComicCollectionViewCell.self, forCellWithReuseIdentifier: "ComicCollectionViewCell")
//        collection.delegate = self
//        collection.dataSource = self
//        return collection
//    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
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
            make.height.equalTo(315)
        }
        
    }

}

extension ComicUIType1Cell {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemArr?.count ?? 0
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ComicCollectionViewCell", for: indexPath) as! ComicCollectionViewCell
        cell.model = itemArr![indexPath.row]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: dwidth, height: 150)
    }

    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 6
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

//    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//
//
//
//    }
}
