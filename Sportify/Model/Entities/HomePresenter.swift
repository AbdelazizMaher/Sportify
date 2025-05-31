//
//  HomePresenter.swift
//  Sportify
//
//  Created by Abdelaziz on 31/05/2025.
//

import Foundation

protocol HomePresenterProtocol {
    var sports: [SportItem] { get }
    func numberOfItems() -> Int
    func item(index: Int) -> SportItem
}


class HomePresenter : HomePresenterProtocol {
    private(set) var sports: [SportItem] = [
        SportItem(name: "Football", imageName: "slide1"),
        SportItem(name: "Basketball", imageName: "slide1"),
        SportItem(name: "Tennis", imageName: "slide1"),
        SportItem(name: "Cricket", imageName: "slide1")
    ]
    
    func numberOfItems() -> Int {
        return sports.count
    }
    
    func item(index: Int) -> SportItem {
        return sports[index]
    }
}
