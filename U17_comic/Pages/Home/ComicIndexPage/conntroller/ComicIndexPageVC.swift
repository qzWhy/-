//
//  ComicIndexPageVCViewController.swift
//  U17_comic
//
//  Created by qingzhou on 2022/4/22.
//

import UIKit

class ComicIndexPageVC: BaseViewController {

    var comicIntroModel: ComicIntroModel?
    
    lazy var scrollview: UIScrollView = {
        let scroll = UIScrollView()
        scroll.backgroundColor = .clear
        scroll.layer.cornerRadius = 20
        scroll.layer.masksToBounds = true
        scroll.delegate = self
        scroll.bounces = false
        scroll.showsVerticalScrollIndicator = false
        scroll.alpha = 1
        scroll.contentSize = CGSize(width: screenWidth, height: screenHeight + 470)
        return scroll
    }()
    
    let topH = SystemUtils.getNavHeight() + SystemUtils.getStatusHeight()
    lazy var bgview: ComicIndexPageBgView = {
        let bgview = ComicIndexPageBgView()
        return bgview
    }()
    
    lazy var headerView: ComicIndexPageHeaderView = {
        let head = ComicIndexPageHeaderView()
        return head
    }()
    lazy var introView: ComicIntroView = {
        let intro = ComicIntroView(frame: CGRect(x: 0, y: 220, width: screenWidth, height: 250))
        intro.backgroundColor = .white
        intro.layer.cornerRadius = 20
        intro.layer.masksToBounds = true
        return intro
    }()
    lazy var btmView: ComicIndexBottomView = {
        let btm = ComicIndexBottomView()
        btm.startReadAction = {
            self.navigationController?.pushViewController(ComicReadViewController(), animated: true)
        }
        return btm
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.addSubview(self.bgview)
        self.view.addSubview(self.scrollview)
        scrollview.addSubview(self.headerView)
        scrollview.addSubview(self.introView)
        scrollview.addSubview(self.tableView)
        self.view.addSubview(btmView)
        tableView.frame = CGRect(x: 0, y: 470, width: screenWidth, height: screenHeight)
        tableView.isScrollEnabled = false
        tableView.bounces = false
        tableView.showsVerticalScrollIndicator = false
    
        loadData()
        qz_barAlpha = 0
        qz_tintColor = .white
        qz_titleColor = UIColor(white: 1, alpha: 0)
        
        
        let topH = SystemUtils.getNavHeight() + SystemUtils.getStatusHeight()
        bgview.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(280 - 20 + SystemUtils.getStatusHeight())
        }
        btmView.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(60)
        }
        scrollview.snp.makeConstraints { make in
            
            make.top.equalTo(self.view).offset(topH)
            make.left.equalTo(self.view)
            make.right.equalTo(self.view)
            make.bottom.equalTo(btmView.snp_top)
        }
        headerView.snp.makeConstraints { make in
            make.top.equalTo(self.view).offset(topH)
            make.left.equalToSuperview()
            make.right.equalTo(self.view)
            make.height.equalTo(220)
        }
    }

}

extension ComicIndexPageVC {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentTableviewCell", for: indexPath) as! CommentTableviewCell
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = SectionHeaderView()
        view.backgroundColor = .white
        return view
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        
        let progress = min(1, max(0, offsetY / 64))
        if progress < 0.1 {
            qz_titleColor = UIColor(white: 1, alpha: 0)
        } else {
            qz_titleColor = UIColor(white: 1, alpha: progress)
        }
        if scrollView == self.scrollview {
            if offsetY >= 478 {
                tableView.isScrollEnabled = true
            } else {
                tableView.isScrollEnabled = false
            }
        } else {
            if offsetY <= 0 {
                tableView.isScrollEnabled = false
            } else {
                tableView.isScrollEnabled = true
            }
        }
        
    }
}




extension ComicIndexPageVC {
    func loadData() {
        
        let param = [
            "comicid" : "13707",
            "device_id": "69EACCA0-47C8-40EE-835F-7C02D8105F93",
            "model": "iPhone%207%20Plus",
            "systemVersion":"13.3.1",
            "target":"U17_3.0",
            "time":SystemUtils.getCurrentSecTime(),
            "version":"5.8.0"
        ]
        
        QZNetWorkManager().request(path: detailSimpleDynamic, params: param) { response in
            let model1: ComicIntroModel = SystemUtils.handyJson(ComicIntroModel.self, response: response)
            self.comicIntroModel = model1
            self.headerView.model = model1.comic
            self.bgview.model = model1.comic
            self.title = model1.comic?.name
        } errorBlock: { error in
            debugPrint(error)
        }

    }
}
