//
//  NewsDetailsViewModelProtocol.swift
//  intro-lab-mdzom
//
//  Created by Gennadij Pleshanov on 04.02.2023.
//

import Foundation

protocol NewsDetailsViewModelProtocol: AnyObject {
    var title: String { get }
    var description: String { get }
    var publicationDate: String { get }
    var publicationSource: String { get }
    var reference: URL? { get }
    func setPicture(complete: @escaping (Data) -> ())
}
