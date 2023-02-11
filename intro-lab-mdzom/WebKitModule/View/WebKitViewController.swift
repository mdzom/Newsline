//
//  WebKitViewController.swift
//  intro-lab-mdzom
//
//  Created by Gennadij Pleshanov on 04.02.2023.
//

import UIKit
import WebKit

class WebKitViewController: UIViewController {
    
    var url: URL? {
        willSet(url) {
            guard let url else { return }
            DispatchQueue.global(qos: .userInitiated).async {
                let request = URLRequest(url: url)
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
                    self?.webView.load(request)
                    self?.activityIndicator.stopAnimating()
                }
            }
        }
    }
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.hidesWhenStopped = true
        indicator.color = .blue
        return indicator
    }()
    
    private lazy var webView: WKWebView = {
        WKWebView()
    }()
    
    private lazy var mainView: UIView = {
        var view = UIView()
        view.backgroundColor = .orange
        view = webView
        return view
    }()
    
    private lazy var returnButton: UIButton = {
        let button = UIButton.init(type: .system)
        button.tintColor = .black
        button.addTarget(self,
                         action: #selector(pushReturnButton),
                         for: .touchUpInside)
        button.setImage(UIImage(systemName: "arrowshape.turn.up.backward"),
                        for: .normal)
        button.backgroundColor = .orange
        button.layer.cornerRadius = 10
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addToView()
        addConstraint()
        activityIndicator.startAnimating()
    }
    
    private func addToView() {
        view.addSubview(mainView)
        view.addSubview(returnButton)
        view.addSubview(activityIndicator)
    }
    
    private func addConstraint() {
        let safeArea = view.safeAreaLayoutGuide
        
        mainView.translatesAutoresizingMaskIntoConstraints = false
        mainView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        mainView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        mainView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        mainView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        returnButton.translatesAutoresizingMaskIntoConstraints = false
        returnButton.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        returnButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        returnButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        returnButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    @IBAction func pushReturnButton() {
        dismiss(animated: true)
    }
}
