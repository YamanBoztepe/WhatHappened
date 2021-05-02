//
//  ViewController.swift
//  WhatHappened
//
//  Created by Yaman Boztepe on 23.04.2021.
//

import UIKit
import CoreLocation

class NewsController: UIViewController {
    
    let extraView = UIView()
    let topView = TopView()
    
    let tableView = UITableView()
    
    var news = NewsAPIDownload(country: "us")
    var newsList: [NewsAPI]? {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLayout()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        getJsonData()
    }
    
    fileprivate func setLayout() {
        
        navigationController?.navigationBar.isHidden = true
        extraView.backgroundColor = UIColor.rgb(187, 25, 25)
        tableView.backgroundColor = UIColor.rgb(242, 242, 242)
        [extraView,topView,tableView].forEach { view.addSubview($0) }
        
        _ = extraView.anchor(top: view.topAnchor, bottom: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor)
        _ = topView.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor,size: .init(width: 0, height: view.frame.height/17))
        
        _ = tableView.anchor(top: topView.bottomAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor)
        
        
        setTableView()
    }
    
    fileprivate func setTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(NewsCell.self, forCellReuseIdentifier: NewsCell.IDENTIFIER)
    }
    
    fileprivate func getJsonData() {
        
        guard let country = Locale.current.regionCode?.lowercased() else { return }
        print(country)
        news = NewsAPIDownload(country: country)
        news.getData { (data) in
            if let jsonData = data {
                self.newsList = jsonData.compactMap(NewsAPI.init)
            } else {
                print("Error Json Data")
            }
        }
    }
    
    @objc fileprivate func shareButtonPressed(button: UIButton) {
        guard let data = newsList?[button.tag].url, let url = URL(string: data) else { return }
        let vc = UIActivityViewController(activityItems: [url], applicationActivities: [])
        present(vc, animated: true)
    }
    
    @objc fileprivate func btnURLPressed(button: UIButton) {
        guard let data = newsList?[button.tag].url, let url = URL(string: data) else { return }
        let vc = WebController()
        vc.url = url
        navigationController?.pushViewController(vc, animated: true)
    }
    
}


extension NewsController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsCell.IDENTIFIER, for: indexPath) as? NewsCell else { return UITableViewCell() }
        
        guard let data = newsList else { return UITableViewCell() }
        cell.setData(data: data[indexPath.row])
        cell.btnShare.tag = indexPath.row
        cell.btnURL.tag = indexPath.row
        cell.btnShare.addTarget(self, action: #selector(shareButtonPressed(button:)), for: .touchUpInside)
        cell.btnURL.addTarget(self, action: #selector(btnURLPressed(button:)), for: .touchUpInside)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height/1.5
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? NewsCell else { return }
        
        if cell.infoView.isHidden == true {
            cell.infoView.isHidden = false
            cell.summaryView.isHidden = true
        } else {
            cell.infoView.isHidden = true
            cell.summaryView.isHidden = false
        }
        
    }
}

