//
//  ComicIntroView.swift
//  U17_comic
//
//  Created by qingzhou on 2022/4/22.
//  简介

import UIKit

class ComicIntroView: UIView {

    /**简介**/
    lazy var introTView: UITextView = {
        let label = UITextView()
        label.textColor = #colorLiteral(red: 0.6666000485, green: 0.6667006016, blue: 0.6665862203, alpha: 1)
        let paraph = NSMutableParagraphStyle()
        //行间距
        paraph.lineSpacing = 5
        //样式属性集合
        label.typingAttributes[NSAttributedString.Key(rawValue: NSAttributedString.Key.font.rawValue)] = font12
        label.typingAttributes[NSAttributedString.Key(rawValue: NSAttributedString.Key.paragraphStyle.rawValue)] = paraph
        label.typingAttributes[NSAttributedString.Key(rawValue: NSAttributedString.Key.foregroundColor.rawValue)] =  #colorLiteral(red: 0.6666000485, green: 0.6667006016, blue: 0.6665862203, alpha: 1)
        label.text = "单元格就是最原始的 UITableViewCell,即里面只有一个文本标签( textLabel)。不过单元格 会随着内部文字自适应高度,使文本标签能将内容完全显示出来。 4, 样例代码 这里注意我..."
        label.isUserInteractionEnabled = false
        label.font = font12
        return label
    }()
    
    lazy var comicUpdateStateLabel: UILabel = {
        let label = UILabel()
        label.text = "连载中"
        label.textColor = titleColor
        label.font = boldFont18
        return label
    }()
    lazy var comicChapterLabel: UILabel = {
        let label = UILabel()
        label.text = "(共413话)"
        label.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        label.font = font14
        return label
    }()
    
    lazy var comicAllCate: UIButton = {
        let btn = UIButton()
        btn.setTitle("全部目录", for: .normal)
        btn.setTitleColor( UIColor.colorWithRGBHex(hex: 0x999999) , for: .normal)
        btn.titleLabel?.font = font14
        return btn
    }()
    
    lazy var comicCoverImgView: UIImageView = {
        let imgView = UIImageView()
        imgView.layer.cornerRadius = 10
        imgView.layer.masksToBounds = true
        imgView.backgroundColor = .red
        return imgView
    }()
    
    lazy var comicLastChapterIntro: UILabel = {
        let label = UILabel()
        label.text = "2019番外-终"
        label.textColor = titleColor
        label.font = boldFont14
        return label
    }()
    lazy var comicLastChapterTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "第245话 2019-08-02"
        label.textColor = titleColor
        label.font = font12
        return label
    }()
    lazy var monthView: MonthPassView = {
        let view = MonthPassView()
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupUI () {
        self.addSubview(self.introTView)
        self.addSubview(self.comicUpdateStateLabel)
        self.addSubview(self.comicChapterLabel)
        self.addSubview(self.comicAllCate)
        self.addSubview(self.comicCoverImgView)
        self.addSubview(self.comicLastChapterIntro)
        self.addSubview(self.comicLastChapterTimeLabel)
        self.addSubview(self.monthView)
        introTView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(80)
            make.top.equalToSuperview().offset(5)
        }
        comicUpdateStateLabel.snp.makeConstraints { make in
            make.top.equalTo(introTView.snp_bottom)
            make.left.equalToSuperview().offset(10)
            make.height.equalTo(20)
        }
        comicChapterLabel.snp.makeConstraints { make in
            make.left.equalTo(comicUpdateStateLabel.snp_right)
            make.bottom.equalTo(comicUpdateStateLabel.snp_bottom)
            make.height.equalTo(14)
        }
        comicAllCate.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-10)
            make.width.equalTo(70)
            make.height.equalTo(30)
            make.centerY.equalTo(comicUpdateStateLabel)
        }
        comicCoverImgView.snp.makeConstraints { make in
            make.top.equalTo(comicUpdateStateLabel.snp.bottom).offset(15)
            make.left.equalToSuperview().offset(10)
            make.width.equalTo(120)
            make.height.equalTo(60)
        }
        comicLastChapterIntro.snp.makeConstraints { make in
            make.left.equalTo(comicCoverImgView.snp_right).offset(10)
            make.centerY.equalTo(comicCoverImgView).offset(-15)
            make.height.equalTo(15)
            make.right.equalToSuperview().offset(-10)
        }
        comicLastChapterTimeLabel.snp.makeConstraints { make in
            make.left.equalTo(comicLastChapterIntro.snp_left)
            make.height.equalTo(12)
            make.centerY.equalTo(comicCoverImgView).offset(12)
            make.right.equalToSuperview().offset(-10)
        }
        monthView.snp.makeConstraints { make in
            make.top.equalTo(comicCoverImgView.snp.bottom).offset(15)
            make.left.right.equalToSuperview()
            make.height.equalTo(60)
        }
    }
}

class MonthPassView: UIView {
    
    lazy var firstImgView:UIImageView = {
        let imgview = UIImageView()
        imgview.layer.cornerRadius = 8
        imgview.layer.masksToBounds = true
        return imgview
    }()
    lazy var giveRewardBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("打赏", for: .normal)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = font12
        btn.layer.cornerRadius = 15
        btn.layer.masksToBounds = true
        btn.backgroundColor = #colorLiteral(red: 0.3511137366, green: 0.881829083, blue: 0.5362711549, alpha: 1)
        return btn
    }()
    
    lazy var monthNumLabel: UILabel = {
        let label = UILabel()
        label.text = "NO.40"
        label.textColor = titleColor
        label.font = boldFont18
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = #colorLiteral(red: 0.9585068822, green: 0.9935211539, blue: 0.979628861, alpha: 1)
        setupUI()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        let label = UILabel()
        label.text = "本月月票"
        label.textColor = titleColor
        label.font = font14
        self.addSubview(label)
        self.addSubview(monthNumLabel)
        self.addSubview(giveRewardBtn)
        label.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
            make.height.equalTo(14)
        }
        monthNumLabel.snp.makeConstraints { make in
            make.left.equalTo(label.snp_right)
            make.centerY.equalToSuperview()
            make.height.equalTo(20)
        }
        giveRewardBtn.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-20)
            make.width.equalTo(60)
            make.height.equalTo(30)
            make.centerY.equalToSuperview()
        }
    }
}
