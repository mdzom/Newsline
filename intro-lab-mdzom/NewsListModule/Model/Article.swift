//
//  Article.swift
//  intro-lab-mdzom
//
//  Created by Gennadij Pleshanov on 04.02.2023.
//

import Foundation

struct Article: Codable {
    let author: String?
    let title, description: String
    let url: String
    let urlToImage: String
    let publishedAt: String
    var count: Int = 0
    
    init?(_ dict: [String: Any]) {
        guard let author = dict["author"] as? String,
              let title = dict["title"] as? String,
              let description = dict["description"] as? String,
              let url = dict["url"] as? String,
              let urlToImage = dict["urlToImage"] as? String,
              let publishedAt = dict["publishedAt"] as? String else {
            return nil
        }
        self.author = author
        self.title = title
        self.description = description
        self.url = url
        self.urlToImage = urlToImage
        self.publishedAt = publishedAt
    }
}
