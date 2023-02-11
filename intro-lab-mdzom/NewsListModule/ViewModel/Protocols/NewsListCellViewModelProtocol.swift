//
//  NewsListCellViewModelProtocol.swift
//  intro-lab-mdzom
//
//  Created by Gennadij Pleshanov on 04.02.2023.
//

import Foundation

protocol NewsListCellViewModelProtocol: AnyObject {
    var title: String { get }
    var count: String { get }
    func setPicture(complete: @escaping (Data) -> ())
}
