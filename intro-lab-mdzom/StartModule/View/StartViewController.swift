//
//  StartViewController.swift
//  intro-lab-mdzom
//
//  Created by Gennadij Pleshanov on 05.02.2023.
//

import UIKit

class StartViewController: UIViewController {
    
    private let viewModel = StartViewModel()
    private let key = "jhgchfjrk67rdtkbjhgc"
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.hidesWhenStopped = true
        indicator.color = .blue
        indicator.startAnimating()
        return indicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addActivityIndicator()
        load()
    }
    
    private func load() {
        guard let data = UserDefaults.standard.value(NewsModel.self,
                                                     forKey: key) else {
            viewModel.loadData { [weak self] model in
                guard let self else { return }
                onMain {
                    UserDefaults.standard.set(encodable: model,
                                              forKey: self.key)
                    self.nextView(model)
                }
            }
            return
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            self?.nextView(data)
        }
    }
    
    private func nextView(_ newsModel: NewsModel) {
        let vm = NewsListViewModel(newsModel: newsModel)
        let vc = ModelBuilder.createNewsListModule(vm)
        activityIndicator.stopAnimating()
        present(vc, animated: false)
    }
    
    private func addActivityIndicator() {
        
        view.addSubview(activityIndicator)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
