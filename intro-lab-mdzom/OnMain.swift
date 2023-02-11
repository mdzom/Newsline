//
//  OnMain.swift
//  intro-lab-mdzom
//
//  Created by Gennadij Pleshanov on 04.02.2023.
//

import Foundation

public func onMain(_ block: @escaping () -> ()) {
    if Thread.isMainThread {
        block()
    } else {
        DispatchQueue.main.async(execute: block)
    }
}
