//
//  NewsListViewController.swift
//  intro-lab-mdzom
//
//  Created by Gennadij Pleshanov on 04.02.2023.
//

import UIKit

class NewsListViewController: UIViewController {
    
    var viewModel: NewsListViewModelProtocol?
    var cellIdentifier = "NewsListCell"
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self,
                                 action: #selector(refreshData),
                                 for: .valueChanged)
        tableView.refreshControl = refreshControl
        tableView.separatorInset.left = 0
        tableView.separatorColor = .orange
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NewsListTableViewCell.self,
                           forCellReuseIdentifier: cellIdentifier)
        return tableView
    }()
    
    private lazy var noInternetLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .red
        label.textAlignment = .center
        label.text = "No internet connection"
        label.alpha = 0.8
        label.isHidden = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        view.addSubview(noInternetLabel)
        addConstraint()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.internetAvailabilityCheck(complete: { [weak self] bool in
            onMain {
                self?.noInternetLabel.isHidden = bool
            }
        })
    }
    
    @IBAction func refreshData() {
        print("refreshData")
        viewModel?.updateData(complete: { [weak self] in
            self?.tableView.refreshControl?.endRefreshing()
            self?.tableView.reloadData()
        })
    }
    
    private func addConstraint() {
        let safeArea = view.safeAreaLayoutGuide
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        noInternetLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            
            noInternetLabel.heightAnchor.constraint(equalToConstant: 50),
            noInternetLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            noInternetLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            noInternetLabel.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }
}
