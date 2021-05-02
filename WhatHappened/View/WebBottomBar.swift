//
//  WebBottomBar.swift
//  WhatHappened
//
//  Created by Yaman Boztepe on 2.05.2021.
//

import UIKit

class WebBottomBar: UIView {
    
    let leftArrow: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "leftArrow")?.withRenderingMode(.alwaysOriginal), for: .normal)
        btn.isEnabled = false
        return btn
    }()
    
    let rightArrow: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "rightArrow")?.withRenderingMode(.alwaysOriginal), for: .normal)
        btn.isEnabled = false
        return btn
    }()
    
    let arrowSV: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.alignment = .fill
        sv.distribution = .fillEqually
        sv.spacing = 5
        return sv
    }()
    
    let btnShare: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "shareWhite")?.withRenderingMode(.alwaysOriginal), for: .normal)
        return btn
    }()
    
    let btnSafari: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "safari")?.withRenderingMode(.alwaysOriginal), for: .normal)
        return btn
    }()
    
    let buttonSV: UIStackView = {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.alignment = .fill
        sv.distribution = .fillEqually
        return sv
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setLayout()
    }
    
    fileprivate func setLayout() {
        
        backgroundColor = UIColor.rgb(38, 38, 38)
        
        [leftArrow,rightArrow].forEach { arrowSV.addArrangedSubview($0) }
        [btnSafari,btnShare].forEach { buttonSV.addArrangedSubview($0) }
        [arrowSV,buttonSV].forEach { addSubview($0) }
        
        _ = arrowSV.anchor(top: topAnchor, bottom: bottomAnchor, leading: leadingAnchor, trailing: nil,size: .init(width: frame.width/4, height: 0),padding: .init(top: 0, left: 10, bottom: 0, right: 0))
        _ = buttonSV.anchor(top: topAnchor, bottom: bottomAnchor, leading: nil, trailing: trailingAnchor,size: .init(width: frame.width/4, height: 0),padding: .init(top: 0, left: 0, bottom: 0, right: 10))
    }
}
