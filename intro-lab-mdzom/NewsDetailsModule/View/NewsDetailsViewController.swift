//
//  NewsDetailsViewController.swift
//  intro-lab-mdzom
//
//  Created by Gennadij Pleshanov on 04.02.2023.
//

import UIKit

class NewsDetailsViewController: UIViewController {
    
    var viewModel: NewsDetailsViewModelProtocol? {
        willSet(viewModel) {
            titleLabel.text = viewModel?.title
            descriptionLabel.text = viewModel?.description
            publicationDateLabel.text = viewModel?.publicationDate
            publicationSourceLabel.text = viewModel?.publicationSource
            viewModel?.setPicture(complete: {[weak self] data in
                onMain {
                    self?.imageView.image = UIImage(data: data)
                    self?.activityIndicator.stopAnimating()
                }
            })
        }
    }
    
    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .center
        view.textColor = .black
        view.numberOfLines = 0
        return view
    }()
    
    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = UIImage(named: "noImage")
        return view
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .center
        view.textColor = .black
        view.numberOfLines = 0
        return view
    }()
    
    private lazy var publicationDateLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .right
        view.textColor = .black
        return view
    }()
    
    private lazy var publicationSourceLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .right
        view.textColor = .black
        return view
    }()
    
    private lazy var fullTextButton: UIButton = {
        let button = UIButton.init(type: .system)
        button.tintColor = UIColor(red: 0.31,
                                   green: 0.545,
                                   blue: 0.867,
                                   alpha: 1)
        button.addTarget(self,
                         action: #selector(pushButton),
                         for: .touchUpInside)
        button.setTitle("Full text of the news",
                        for: .normal)
        return button
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.hidesWhenStopped = true
        indicator.color = .blue
        return indicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addToView()
        addConstraint()
    }
    
    private func addToView() {
        view.addSubview(titleLabel)
        view.addSubview(imageView)
        view.addSubview(descriptionLabel)
        view.addSubview(publicationDateLabel)
        view.addSubview(publicationSourceLabel)
        view.addSubview(fullTextButton)
        view.addSubview(activityIndicator)
    }
    
    private func addConstraint() {
        let safeArea = view.safeAreaLayoutGuide
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
        imageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        imageView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 5).isActive = true
        descriptionLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        descriptionLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        
        publicationDateLabel.translatesAutoresizingMaskIntoConstraints = false
        publicationDateLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 30).isActive = true
        publicationDateLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        publicationDateLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        
        publicationSourceLabel.translatesAutoresizingMaskIntoConstraints = false
        publicationSourceLabel.topAnchor.constraint(equalTo: publicationDateLabel.bottomAnchor, constant: 5).isActive = true
        publicationSourceLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        publicationSourceLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        
        fullTextButton.translatesAutoresizingMaskIntoConstraints = false
        fullTextButton.topAnchor.constraint(equalTo: publicationSourceLabel.bottomAnchor, constant: 10).isActive = true
        fullTextButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        fullTextButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16).isActive = true
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerXAnchor.constraint(equalTo: imageView.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: imageView.centerYAnchor).isActive = true
    }
    
    @IBAction func pushButton() {
        print("переход в webkit")
        guard let viewModel else { return }
        let vc = WebKitViewController()
        vc.url = viewModel.reference
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
        
    }
}
