//
//  NewsModel.swift
//  intro-lab-mdzom
//
//  Created by Gennadij Pleshanov on 04.02.2023.
//

import Foundation

class NewsModel: Codable {
    var articles: [Article]
    
    init?(_ json: Any) {
        guard let dictionary = json as? [String: Any],
              let results = dictionary["articles"] as? [[String: Any]] else {
            return nil
        }
        var result = [Article]()
        for index in results.prefix(20) {
            guard let extract = Article(index) else { continue }
            result.append(extract)
        }
        self.articles = result
    }
    
    init() {
        articles = []
    }
}
