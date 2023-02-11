//
//  NewsDetailsViewModel.swift
//  intro-lab-mdzom
//
//  Created by Gennadij Pleshanov on 04.02.2023.
//

import Foundation

class NewsDetailsViewModel: NewsDetailsViewModelProtocol {
    
    private var news: Article
    private var network = NetworkService()
    
    var title: String {
        news.title
    }
    
    var description: String {
        news.description
    }
    
    var publicationDate: String {
        dateFormatting(news.publishedAt)
    }
    
    var reference: URL? {
        guard let url = URL(string: news.url) else {
            return nil
        }
        return url
    }
    
    var publicationSource: String {
        guard let autor = news.author else {
            return ""
        }
        return autor
    }
    
    init(_ news: Article) {
        self.news = news
    }
    
    func setPicture(complete: @escaping (Data) -> ()) {
        network.loadImage(data: news.urlToImage) { data in
            complete(data)
        }
    }
    
    private func dateFormatting(_ text: String) -> String {
        var formattedDate = ""
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        if let date = dateFormatter.date(from: text) {
            dateFormatter.dateFormat = "MMM d, yyyy"
            formattedDate = dateFormatter.string(from: date)
        }
        return formattedDate
    }
}
