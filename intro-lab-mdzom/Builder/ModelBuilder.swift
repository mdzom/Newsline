//
//  ModelBuilder.swift
//  intro-lab-mdzom
//
//  Created by Gennadij Pleshanov on 04.02.2023.
//

import UIKit

final class ModelBuilder: Builder {
    
    static func createStartModule() -> UIViewController {
        let vc = StartViewController()
        return vc
    }
    
    static func createNewsListModule(_ vm: NewsListViewModelProtocol) -> UIViewController {
        let vc = NewsListViewController()
        vc.viewModel = vm
        vc.view.backgroundColor = .white
        let navigation = UINavigationController(rootViewController: vc)
        navigation.modalPresentationStyle = .fullScreen
        navigation.modalTransitionStyle = .flipHorizontal
        return navigation
    }
}
