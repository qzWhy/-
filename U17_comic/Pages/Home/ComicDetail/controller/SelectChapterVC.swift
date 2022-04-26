//
//  SelectChapterVC.swift
//  U17_comic
//
//  Created by qingzhou on 2022/4/25.
//  选择章节 下载

import UIKit

class SelectChapterVC: UIViewController {

    lazy var topleftLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 10, y: 22, width: 200, height: 20))
        label.text = "连载中 共25话"
        label.textColor = UIColor.colorWithRGBHex(hex: 0x999999)
        label.font = font12
        return label
    }()
    lazy var rightBtn: UIButton = {
        let btn = UIButton()
        btn.setTitleColor(UIColor.green, for: .normal)
        btn.setImage(UIImage(named: "top_arrow"), for: .normal)
        btn.z_width = 30
        btn.z_height = 20
        btn.setTitle("倒序", for: .normal)
        btn.titleLabel?.font = font12
        btn.layoutButtonWithEdgeInsetsStyle(.styleRight, 2)
        return btn
    }()
    lazy var bottomleftBar: UIView = {
        let label = UILabel()
        label.text = "连载中 共25话"
        label.textColor = UIColor.colorWithRGBHex(hex: 0x999999)
        label.font = font12
        return label
    }()
    
    lazy var bottomrightBar: UIView = {
        let label = UILabel()
        label.text = "已选0话 共0.00MB"
        label.textColor = UIColor.colorWithRGBHex(hex: 0x999999)
        label.textAlignment = .right
        label.font = font12
        return label
    }()
    
    lazy var btmView:UIView = {
        let btm = UIView()
        
        let leftBtn = UIButton(frame: CGRect(x: 0, y: 0, width: screenWidth/2, height: 60))
        leftBtn.setTitle("取消", for: .normal)
        leftBtn.setTitleColor(UIColor.colorWithRGBHex(hex: 0x333333), for: .normal)
        btm.addSubview(leftBtn)
        
        let rightBtn = UIButton(frame: CGRect(x: screenWidth / 2, y: 0, width: screenWidth/2, height: 60))
        rightBtn.setTitle("下载", for: .normal)
        rightBtn.setTitleColor(UIColor.colorWithRGBHex(hex: 0x333333), for: .normal)
        rightBtn.addTarget(self, action: #selector(downloadBtnClick), for: .touchUpInside)
        btm.addSubview(rightBtn)
        
        return btm
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = .zero
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        let collect = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collect.backgroundColor = bgColor
        collect.register(ChapterNumbCell.self, forCellWithReuseIdentifier: "ChapterNumbCell")
        collect.delegate = self
        collect.dataSource = self
        return collect
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "选择章节"
        self.view.backgroundColor = bgColor
        setupUI()
        
    }
    

    func setupUI() {
        self.view.addSubview(collectionView)
        self.view.addSubview(topleftLabel)
        view.addSubview(rightBtn)
        view.addSubview(btmView)
        let btmview = UIView()
        btmview.backgroundColor = UIColor.colorWithRGBHex(hex: 0x333333)
        view.addSubview(btmview)
        
        btmview.addSubview(bottomleftBar)
        btmview.addSubview(bottomrightBar)
        btmView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(60)
        }
        collectionView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(topleftLabel.snp_bottom).offset(20)
            make.bottom.equalTo(btmview.snp_top)
        }
        topleftLabel.snp.makeConstraints { make in
            make.top.equalTo(self.view.qsnp.top).offset(22)
            make.height.equalTo(20)
            make.width.equalTo(200)
            make.left.equalToSuperview().offset(15)
        }
        rightBtn.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-10)
            make.width.equalTo(60)
            make.height.equalTo(20)
            make.centerY.equalTo(topleftLabel)
        }
        btmview.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.height.equalTo(40)
            make.bottom.equalTo(btmView.snp_top)
        }
        bottomleftBar.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.centerY.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(20)
        }
        bottomrightBar.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-10)
            make.centerY.equalToSuperview()
            make.height.equalTo(20)
            make.width.equalToSuperview()
        }
    }
    
    @objc func downloadBtnClick() {
        
    }

}

extension SelectChapterVC: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChapterNumbCell", for: indexPath) as! ChapterNumbCell
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellW:CGFloat = (screenWidth - 70) / 4
        let cellH:CGFloat = 40
        return CGSize(width: cellW, height: cellH)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
}
