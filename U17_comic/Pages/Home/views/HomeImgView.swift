//
//  HomeImgView.swift
//  dctt_qz
//
//  Created by qingzhou on 2022/4/11.
//

import UIKit

class HomeImgView: UIView {

    let ImgWidth = (screenWidth - 16*2 - 2*5)/3
    
    var model: HModel? {
        didSet {
            let imgStr = model?.images
            let imgArr:[String] = imgStr?.split(separator: ",") as! [String]
            if imgArr.count == 1 {
                let imgView = UIImageView(frame: CGRect(x: 16, y: 0, width: ImgWidth + 10 , height: ImgWidth + 10))
                let url = URL(string: imgArr[0])
                imgView.kf.setImage(with: url, placeholder: UIImage(named: "avatar_default"))
                self.addSubview(imgView)
            } else {
                for i in 0..<imgArr.count {
                    let imageView = UIImageView(frame: CGRect(x: 16 + CGFloat(i)*(ImgWidth + 5), y: 0, width: ImgWidth, height: ImgWidth))
                    self.addSubview(imageView)
                }
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI () {
        
    }

}
