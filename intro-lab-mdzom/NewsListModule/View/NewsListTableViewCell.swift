//
//  NewsListTableViewCell.swift
//  intro-lab-mdzom
//
//  Created by Gennadij Pleshanov on 04.02.2023.
//

import UIKit

class NewsListTableViewCell: UITableViewCell {
    
    weak var viewModel: NewsListCellViewModelProtocol? {
        willSet(viewModel) {
            titleLabel.text = viewModel?.title
            countLabel.text = viewModel?.count
            viewModel?.setPicture(complete: {[weak self] data in
                onMain {
                    self?.image.image = UIImage(data: data)
                    self?.activityIndicator.stopAnimating()
                }
            })
        }
    }
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.hidesWhenStopped = true
        indicator.color = .blue
        return indicator
    }()
    
    private lazy var image: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.image = UIImage(named: "noImage")
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .left
        view.textColor = .black
        view.numberOfLines = 0
        return view
    }()
    
    private lazy var countLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .right
        view.textColor = .black
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addToView()
        addConstraint()
        activityIndicator.startAnimating()
        contentView.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addToView() {
        contentView.addSubview(image)
        contentView.addSubview(titleLabel)
        contentView.addSubview(countLabel)
        contentView.addSubview(activityIndicator)
    }
    
    private func addConstraint() {
        
        image.translatesAutoresizingMaskIntoConstraints = false
        image.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16).isActive = true
        image.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16).isActive = true
        image.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16).isActive = true
        image.widthAnchor.constraint(equalTo: image.heightAnchor).isActive = true
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.leftAnchor.constraint(equalTo: image.rightAnchor, constant: 16).isActive = true
        titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16).isActive = true
        titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16).isActive = true
        titleLabel.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        countLabel.leftAnchor.constraint(equalTo: image.rightAnchor, constant: 16).isActive = true
        countLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16).isActive = true
        countLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16).isActive = true
        countLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerXAnchor.constraint(equalTo: image.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: image.centerYAnchor).isActive = true
    }
}
