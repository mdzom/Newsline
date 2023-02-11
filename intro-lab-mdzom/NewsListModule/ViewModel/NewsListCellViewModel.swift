//
//  NewsListCellViewModel.swift
//  intro-lab-mdzom
//
//  Created by Gennadij Pleshanov on 04.02.2023.
//

import Foundation

class NewsListCellViewModel: NewsListCellViewModelProtocol {
    
    private var news: Article
    private var network = NetworkService()
    
    var title: String {
        news.title
    }
    
    var count: String {
        "\(news.count)"
    }
    
    func setPicture(complete: @escaping (Data) -> ()) {
        network.loadImage(data: news.urlToImage) { data in
            complete(data)
        }
    }
    
    init(_ news: Article) {
        self.news = news
    }
}
