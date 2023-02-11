//
//  NewsListViewModelProtocol.swift
//  intro-lab-mdzom
//
//  Created by Gennadij Pleshanov on 04.02.2023.
//

import Foundation

protocol NewsListViewModelProtocol: AnyObject {
    func numberOfRows() -> Int
    func createCellViewModel(for indexPath: IndexPath) -> NewsListCellViewModelProtocol?
    func createNewsDetailsViewModel(for indexPath: IndexPath) -> NewsDetailsViewModelProtocol?
    func viewModelForSelectedRow() -> NewsDetailsViewController?
    func selectRow(at indexPath: IndexPath)
    func increaseViewCount(for indexPath: IndexPath)
    func internetAvailabilityCheck(complete: @escaping (Bool) -> ())
    func updateData(complete: @escaping () -> ())
}
