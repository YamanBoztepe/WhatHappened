//
//  WebBar.swift
//  WhatHappened
//
//  Created by Yaman Boztepe on 2.05.2021.
//

import UIKit

class WebBar: UIView {
    
    let doneButton: UIButton = {
        let btn = UIButton()
        btn.setTitle("Done", for: .normal)
        btn.titleLabel?.numberOfLines = 0
        return btn
    }()
    
    let urlField: UITextField = {
        let txt = UITextField()
        txt.backgroundColor = UIColor.rgb(64, 64, 64)
        txt.textColor = .lightGray
        txt.textAlignment = .center
        txt.layer.cornerRadius = 10
        txt.isUserInteractionEnabled = false
        return txt
    }()
    
    let refreshButton: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "refresh")?.withRenderingMode(.alwaysOriginal), for: .normal)
        return btn
    }()
    
    let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.hidesWhenStopped = true
        spinner.color = .white
        return spinner
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setLayout()
    }
    
    fileprivate func setLayout() {
        
        backgroundColor = UIColor.rgb(38, 38, 38)
        
        [doneButton,urlField,refreshButton,spinner].forEach { addSubview($0) }
        
        _ = doneButton.anchor(top: topAnchor, bottom: bottomAnchor, leading: leadingAnchor, trailing: nil,size: .init(width: frame.width/8, height: 0), padding: .init(top: 0, left: 5, bottom: 0, right: 0))
        
        urlField.positionInCenterSuperView(size: .init(width: frame.width/1.5, height: frame.height/1.7), centerX: centerXAnchor, centerY: centerYAnchor)
        
        _ = refreshButton.anchor(top: urlField.topAnchor, bottom: urlField.bottomAnchor, leading: urlField.trailingAnchor, trailing: nil,size: .init(width: frame.width/8, height: 0))
        
        _ = spinner.anchor(top: urlField.topAnchor, bottom: urlField.bottomAnchor, leading: urlField.trailingAnchor, trailing: nil,size: .init(width: frame.width/8, height: 0))
    }
}
