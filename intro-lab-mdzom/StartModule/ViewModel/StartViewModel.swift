//
//  StartViewModel.swift
//  intro-lab-mdzom
//
//  Created by Gennadij Pleshanov on 05.02.2023.
//

import Foundation

class StartViewModel {
    
    private var network = NetworkService()

    func loadData(complete: @escaping (NewsModel) -> ()) {

        network.getDataModel { data in
            complete(data)
        }
    }
}
