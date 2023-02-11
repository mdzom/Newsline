//
//  NewsListViewModel.swift
//  intro-lab-mdzom
//
//  Created by Gennadij Pleshanov on 04.02.2023.
//

import Foundation
import Network

class NewsListViewModel: NewsListViewModelProtocol {
    
    private let key = "jhgchfjrk67rdtkbjhgc"
    private var selectedIndexPath: IndexPath?
    private var network = NetworkService()
    private var newsModel: NewsModel
    private let monitor = NWPathMonitor()
    
    func updateData(complete: @escaping () -> ()) {
        network.getDataModel { [weak self] data in
            self?.newsModel = data
            self?.saveData()
        }
        complete()
    }
    
    private func saveData() {
        UserDefaults.standard.set(encodable: newsModel,
                                  forKey: key)
    }
    
    func internetAvailabilityCheck(complete: @escaping (Bool) -> ()) {
        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                complete(true)
            } else {
                complete(false)
            }
        }
    }
    
    func createCellViewModel(for indexPath: IndexPath) -> NewsListCellViewModelProtocol? {
        let news = newsModel.articles[indexPath.row]
        return NewsListCellViewModel(news)
    }
    
    func createNewsDetailsViewModel(for indexPath: IndexPath) -> NewsDetailsViewModelProtocol? {
        let news = newsModel.articles[indexPath.row]
        return NewsDetailsViewModel(news)
    }
    
    func viewModelForSelectedRow() -> NewsDetailsViewController? {
        guard let selectedIndexPath else { return nil }
        let news = newsModel.articles[selectedIndexPath.row]
        let vc = NewsDetailsViewController()
        vc.viewModel = NewsDetailsViewModel(news)
        return vc
    }
    
    func selectRow(at indexPath: IndexPath) {
        selectedIndexPath = indexPath
    }
    
    func numberOfRows() -> Int {
        newsModel.articles.count
    }
    
    func increaseViewCount(for indexPath: IndexPath) {
        var temp = newsModel.articles[indexPath.row]
        temp.count += 1
        newsModel.articles[indexPath.row] = temp
        saveData()
    }
    
    init(newsModel: NewsModel) {
        self.newsModel = newsModel
    }
}
