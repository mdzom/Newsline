//
//  Builder.swift
//  intro-lab-mdzom
//
//  Created by Gennadij Pleshanov on 04.02.2023.
//

import UIKit

protocol Builder {
    static func createStartModule() -> UIViewController
    static func createNewsListModule(_ vm: NewsListViewModelProtocol) -> UIViewController
}
