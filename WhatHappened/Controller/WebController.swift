//
//  WebController.swift
//  WhatHappened
//
//  Created by Yaman Boztepe on 2.05.2021.
//

import UIKit
import WebKit

class WebController: UIViewController {

    let extraView = UIView()
    let webBar = WebBar()
    
    let webView: WKWebView = {
        let prefs = WKWebpagePreferences()
        prefs.allowsContentJavaScript = true
        
        let configuration = WKWebViewConfiguration()
        configuration.defaultWebpagePreferences = prefs
        
        let wv = WKWebView(frame: .zero, configuration: configuration)
        return wv
    }()
    
    let webBottomBar = WebBottomBar()
    
    var url: URL = URL(string: "https://www.google.com")!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        webView.load(URLRequest(url: url))
        webView.navigationDelegate = self
        setLayout()
    }
    
    fileprivate func setLayout() {
        
        navigationController?.navigationBar.isHidden = true
        extraView.backgroundColor = UIColor.rgb(38, 38, 38)
        [extraView,webBar,webView,webBottomBar].forEach { view.addSubview($0) }
        
        _ = extraView.anchor(top: view.topAnchor, bottom: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor)
        _ = webBar.anchor(top: view.safeAreaLayoutGuide.topAnchor, bottom: nil, leading: view.leadingAnchor, trailing: view.trailingAnchor,size: .init(width: 0, height: view.frame.height/15))
        _ = webView.anchor(top: webBar.bottomAnchor, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor)
        _ = webBottomBar.anchor(top: nil, bottom: view.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor,size: .init(width: 0, height: view.frame.height/15))
        
        webBar.urlField.text = shortURL(urlHost: url.host!)
        
        webBar.doneButton.addTarget(self, action: #selector(doneButtonPressed), for: .touchUpInside)
        webBar.refreshButton.addTarget(self, action: #selector(refreshButtonPressed), for: .touchUpInside)
        
        webBottomBar.btnShare.addTarget(self, action: #selector(shareButtonPressed), for: .touchUpInside)
        webBottomBar.btnSafari.addTarget(self, action: #selector(safariButtonPressed), for: .touchUpInside)
        webBottomBar.leftArrow.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        webBottomBar.rightArrow.addTarget(self, action: #selector(forwardButtonPressed), for: .touchUpInside)
    }
    
    fileprivate func shortURL(urlHost: String) -> String {
        
        if urlHost.hasPrefix("www.") {
            return String(urlHost.dropFirst(4))
        }
        return urlHost
    }
    
    @objc fileprivate func doneButtonPressed() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc fileprivate func refreshButtonPressed() {
        webView.reload()
    }
    
    @objc fileprivate func shareButtonPressed() {
        
        guard let shareButton = webView.url else { return }
        let vc = UIActivityViewController(activityItems: [shareButton], applicationActivities: [])
        present(vc, animated: true)
    }
    
    @objc fileprivate func safariButtonPressed() {
        guard let safariURL = webView.url else { return }
        UIApplication.shared.open(safariURL)
    }
    
    @objc fileprivate func backButtonPressed() {
        webView.goBack()
    }
    
    @objc fileprivate func forwardButtonPressed() {
        webView.goForward()
    }
    
    
}

extension WebController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        webBar.refreshButton.isHidden = true
        webBar.spinner.startAnimating()
        
        guard let urlString = webView.url?.host else { return }
        webBar.urlField.text = shortURL(urlHost: urlString)
        
        webBottomBar.leftArrow.isEnabled = webView.canGoBack
        webBottomBar.rightArrow.isEnabled = webView.canGoForward
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webBar.spinner.stopAnimating()
        webBar.refreshButton.isHidden = false
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        webBar.spinner.stopAnimating()
        webBar.refreshButton.isHidden = false
    }
}
