//
//  ListenNews.swift
//  ListeningNews
//
//  Created by duoda james on 2018/9/16.
//  Copyright © 2018年 Butterfly Tech. All rights reserved.
//

import Foundation

struct Articles: Codable {
    let articles: [Article]?
    
    init(articles: [Article]) {
        self.articles = articles
    }
}

struct Article: Codable {
    let title: String
    let description: String
    let url: String
    let urlToImage: String?
    let publishedAt: String
    let content: String?
    let author: String?
}
