//
//  NewsCell.swift
//  WhatHappened
//
//  Created by Yaman Boztepe on 23.04.2021.
//

import UIKit

class NewsCell: UITableViewCell {
    
    static let IDENTIFIER = "NewsCell"
    
    private let lblTitle: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = .preferredFont(forTextStyle: .title2)
        
        lbl.text = "..."
        lbl.numberOfLines = 0
        return lbl
    }()
    
    private let imgNews: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        return img
    }()
    
    private let lblDate: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .lightGray
        lbl.text = "..."
        return lbl
    }()
    
    let btnShare: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "share")?.withRenderingMode(.alwaysOriginal), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        return btn
    }()
    
    let btnURL: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "rightArray")?.withRenderingMode(.alwaysOriginal), for: .normal)
        btn.imageView?.contentMode = .scaleAspectFit
        return btn
    }()
    
    
    private let detailsSV: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        return sv
    }()
    
    let summaryView = UIView()
    
    let infoView: UIView = {
        let view = UIView()
        view.isHidden = true
        return view
    }()
    
    let lblInfo: UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.font = .preferredFont(forTextStyle: .title3)
        lbl.text = "..."
        lbl.numberOfLines = 0
        return lbl
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setLayout()
    }
    
    fileprivate func setLayout() {
        
        selectionStyle = .none
        backgroundColor = UIColor.rgb(242, 242, 242)
        
        [lblDate, btnShare].forEach { detailsSV.addArrangedSubview($0) }
        [lblTitle, imgNews, detailsSV].forEach { summaryView.addSubview($0) }
        [lblInfo, btnURL].forEach { infoView.addSubview($0) }
        [summaryView,infoView].forEach { addSubview($0) }
        
        _ = infoView.anchor(top: topAnchor, bottom: bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor,padding: .init(top: frame.width/24, left: frame.width/24, bottom: frame.width/24, right: frame.width/24))
        _ = lblInfo.anchor(top: infoView.topAnchor, bottom: nil, leading: infoView.leadingAnchor, trailing: infoView.trailingAnchor,size: .init(width: 0, height: infoView.frame.height/1.1))
        _ = btnURL.anchor(top: nil, bottom: infoView.bottomAnchor, leading: nil, trailing: infoView.trailingAnchor,padding: .init(top: 0, left: 0, bottom: 0, right: 5))
        
        _ = summaryView.anchor(top: topAnchor, bottom: bottomAnchor, leading: leadingAnchor, trailing: trailingAnchor,padding: .init(top: frame.width/22, left: 0, bottom: frame.width/22, right: 0))
        _ = lblTitle.anchor(top: summaryView.topAnchor, bottom: nil, leading: summaryView.leadingAnchor, trailing: summaryView.trailingAnchor,padding: .init(top: 0, left: frame.width/20, bottom: 0, right: frame.width/20))
        _ = imgNews.anchor(top: lblTitle.bottomAnchor, bottom: detailsSV.topAnchor, leading: summaryView.leadingAnchor, trailing: summaryView.trailingAnchor,padding: .init(top: frame.width/25, left: 0, bottom: 5, right: 0))
        _ = detailsSV.anchor(top: nil, bottom: summaryView.bottomAnchor, leading: lblTitle.leadingAnchor, trailing: lblTitle.trailingAnchor,size: .init(width: 0, height: frame.height/25),padding: .init(top: 0, left: 0, bottom: 0, right: 0))
        
        
    }
    
    func setData(data: NewsAPI) {
        
        self.lblTitle.text = data.title
        self.lblDate.text = getDate(string: data.publishedAt)
        self.lblInfo.text = data.description
        
        guard let imgURL = URL(string: data.urlToImage) else { return }
        URLSession.shared.dataTask(with: imgURL) { (data, _, error) in
            
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            if let data = data {
                DispatchQueue.main.async {
                    self.imgNews.image = UIImage(data: data)?.withRenderingMode(.alwaysOriginal)
                    
                }
            }
        }.resume()
    }
    
    fileprivate func getDate(string: String) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let date = dateFormatter.date(from: string)
        guard let styledDate = date?.description.prefix(16) else { return "00:00:00"}
        return String(styledDate)
        
    }
    
}
