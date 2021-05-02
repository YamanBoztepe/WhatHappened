//
//  NewsAPIDownload.swift
//  WhatHappened
//
//  Created by Yaman Boztepe on 26.04.2021.
//

import Foundation

class NewsAPIDownload {
    
    private var baseURL = URL(string: "")
    
    init(country: String) {
        baseURL = URL(string: "https://newsapi.org/v2/top-headlines?country=\(country)&apiKey=5ef4d64bf0fd4116a40021b26a7d1db5")
    }
    
    func getData(completionHandler completion: @escaping ([Article]?) -> Void) {
        
        guard let url = baseURL else { print("baseURL is nil");return }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
                return
            }
            
            guard let apiData = data else { completion(nil);return }
            
            do {
                let results = try JSONDecoder().decode(NewsAPIModel.self, from: apiData)
                completion(results.articles)
            } catch {
                print(error.localizedDescription)
                completion(nil)
            }
        }.resume()
    }
}
