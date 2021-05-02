//
//  TopView.swift
//  WhatHappened
//
//  Created by Yaman Boztepe on 23.04.2021.
//

import UIKit

class TopView: UIView {
    
    private let lblTitle: UILabel = {
        let lbl = UILabel()
        lbl.text = "WhatHappened"
        lbl.textColor = .white
        lbl.font = UIFont.boldSystemFont(ofSize: 20)
        return lbl
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setLayout()
    }
    
    fileprivate func setLayout() {
        
        addSubview(lblTitle)
        
        backgroundColor = UIColor.rgb(187, 25, 25)
        lblTitle.positionInCenterSuperView(centerX: centerXAnchor, centerY: centerYAnchor)
    }
}
