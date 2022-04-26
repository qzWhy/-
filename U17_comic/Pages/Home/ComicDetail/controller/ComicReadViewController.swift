//
//  ComicReadViewController.swift
//  U17_comic
//
//  Created by qingzhou on 2022/4/24.
//

import UIKit
import CWLog
import HandyJSON

class ComicReadViewController: UIViewController {

    let topH = SystemUtils.getNavHeight() + SystemUtils.getStatusHeight()
    
    var dataSource: [ComicDetailChapterModel] = []
    
    var isBarHidden: Bool = false {
        didSet {
            UIView.animate(withDuration: 0.5) { [self] in
                self.topBar.frame.origin.y = isBarHidden ? -topH : 0
            }
        }
    }
    
    lazy var backScrollview: UIScrollView = {
        let scroll = UIScrollView()
        scroll.delegate = self
        scroll.minimumZoomScale = 1.0
        scroll.maximumZoomScale = 1.5
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapAction))
        tap.numberOfTapsRequired = 1
        scroll.addGestureRecognizer(tap)
        scroll.backgroundColor = .green
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(doubleTapAction))
        doubleTap.numberOfTapsRequired = 2
        scroll.addGestureRecognizer(doubleTap)
        tap.require(toFail: doubleTap)
        return scroll
    }()
    
    lazy var topBar: ComicReadTopBar = {
        let topBar = ComicReadTopBar()
        topBar.btnClickBlock = { tag in
            if tag == 102 {
                self.navigationController?.pushViewController(SelectChapterVC(), animated: true)
            }
        }
        topBar.backBtnBlock = {
            self.navigationController?.popViewController(animated: true)
        }
        return topBar
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sectionInset = .zero
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.register(ComicDetailImgCell.self, forCellWithReuseIdentifier: "ComicDetailImgCell")
        collection.backgroundColor = .black
        collection.isPagingEnabled = true
        collection.delegate = self
        collection.dataSource = self
        return collection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        loadDataSource()
    }
    

    func setupUI() {
        view.backgroundColor = .white
        view.addSubview(self.backScrollview)
        backScrollview.addSubview(collectionView)
        view.addSubview(self.topBar)
        topBar.snp.makeConstraints { make in
            make.top.equalTo(backScrollview)
            make.left.right.equalTo(backScrollview)
            make.height.equalTo(topH)
        }
        backScrollview.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.top.equalTo(self.view.snp_top)
            make.bottom.equalTo(backScrollview)
            make.width.equalTo(backScrollview)
            make.height.equalTo(backScrollview)
        }
    }
    

}

extension ComicReadViewController {
    @objc func tapAction() {
        isBarHidden = !isBarHidden
    }
    @objc func doubleTapAction() {
        var zoomScale = backScrollview.zoomScale
        zoomScale = 2.5 - zoomScale
        let width = view.frame.width / zoomScale
        let height = view.frame.height / zoomScale
        let zoomRect = CGRect(x: backScrollview.center.x - width / 2, y: backScrollview.center.y - height / 2, width: width, height: height)
        backScrollview.zoom(to: zoomRect, animated: true)
    }
}

extension ComicReadViewController : UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataSource.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource[section].image_list?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ComicDetailImgCell", for: indexPath) as! ComicDetailImgCell
        cell.model = dataSource[indexPath.section].image_list?[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: screenWidth, height: screenHeight)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
    
}
/**网络请求**/
extension ComicReadViewController {
    func loadDataSource() {
        let r = "56745"
        let da: String = r.base64EncodedStringWithWrapWidth(wrapWidth: 0)!
        let characterSet = CharacterSet(charactersIn: "=")
        let cid = da.trimmingCharacters(in: characterSet)
        debugPrint(cid)
        let param = [
            "chapter_id": cid
        ]
        
        QZNetWorkManager().request(method: .get, path: detailChapter, params: param, isShowHud: false, isShowError: false, isAnalysis: true) { response in
            CWLog(response)
            
            let datas: [ComicDetailChapterModel] = []
            
            if let data = response.data, let returnData = data["data"]{
                let json = returnData as! NSDictionary
                let update = json["returnData"] as! Array<Any>
                var dataSource:[ComicDetailChapterModel] = []
                for item in update {
                    let it = item as! NSDictionary
                    let mmodel: ComicDetailChapterModel = JSONDeserializer<ComicDetailChapterModel>.self.deserializeFrom(dict: it)!
                    dataSource.append(mmodel)
                }
                debugPrint(dataSource)
                self.dataSource = dataSource
                self.collectionView.reloadData()
            }
            
//            let model1: ComicDetailChapterModel = SystemUtils.handyJson(ComicDetailChapterModel.self, response: response)
//            debugPrint(model1)
        } errorBlock: { error in
            debugPrint(error)
        }

//        ApiProvider.request(NetManager.chapterNewBatch(chapter_id: chapterid), completion: <#T##Completion##Completion##(_ result: Result<Response, MoyaError>) -> Void#>)
//        ApiProvider.request(NetManager.chapterNewBatch(chapter_id: chapterid), model: commentModel.self) { returnData in
//            debugPrint(returnData)
//        }

    }
}
