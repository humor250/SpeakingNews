//
//  DataSource.swift
//  SayingNews
//
//  Created by duoda james on 2018/9/20.
//  Copyright © 2018年 Butterfly Tech. All rights reserved.
//

import Foundation

struct DataSource {
    
    static let newsArray = ["Google", "ABC", "Financial Times", "Fox", "TechCrunch", "NBC"]
    static let googleNewsTop = URL(string: "https://newsapi.org/v2/top-headlines?sources=google-news&apiKey=a2e329529fe64e718d4737ed70c9e1db")
    static let googleNewsWithSearch = URL(string: "https://newsapi.org/v2/everything?q=bitcoin&apiKey=a2e329529fe64e718d4737ed70c9e1db")
    static let ABCNews = URL(string: "https://newsapi.org/v2/top-headlines?sources=abc-news&apiKey=a2e329529fe64e718d4737ed70c9e1db")
    static let financialTimes = URL(string: "https://newsapi.org/v2/top-headlines?sources=financial-times&apiKey=a2e329529fe64e718d4737ed70c9e1db")
    static let foxNews = URL(string: "https://newsapi.org/v2/top-headlines?sources=fox-news&apiKey=a2e329529fe64e718d4737ed70c9e1db")
    static let techcrunch = URL(string: "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=a2e329529fe64e718d4737ed70c9e1db")
    static let techcrunch_cn = URL(string: "https://newsapi.org/v2/top-headlines?sources=techcrunch-cn&apiKey=a2e329529fe64e718d4737ed70c9e1db")
    static let NBCNews = URL(string: "https://newsapi.org/v2/top-headlines?sources=nbc-news&apiKey=a2e329529fe64e718d4737ed70c9e1db")
}
