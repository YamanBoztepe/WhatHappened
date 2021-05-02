//
//  NewsAPIModel.swift
//  WhatHappened
//
//  Created by Yaman Boztepe on 26.04.2021.
//

import Foundation

struct Article: Codable {
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let content: String?
    let publishedAt: String?
}

struct NewsAPIModel: Codable {
    let articles: [Article]
}

struct NewsAPI {
    let title: String
    let description: String
    let url: String
    let urlToImage: String
    let content: String
    let publishedAt: String
    
    init(data: Article) {
        self.title = data.title ?? "..."
        self.description = data.description ?? "..."
        self.url = data.url ?? "URL is not found"
        self.urlToImage = data.urlToImage ?? ""
        self.content = data.content ?? "...t"
        self.publishedAt = data.publishedAt ?? "00:00:00"
    }
}
