//
//  Categorias.swift
//  RenewCycle
//
//  Created by Miguel Pérez León on 1/7/25.
//

import Foundation

enum Categories: String, Codable, CaseIterable, Identifiable {
    case technology = "Technology"
    case sports = "Sports"
    case clothing = "Clothing"
    case car = "Car"
    
    var id: Self { self }
}

func getCategoryIcon(category: Categories) -> String {
    switch category {
    case Categories.technology:
        return "macbook.and.iphone"
    case Categories.sports:
        return "bicycle"
    case Categories.clothing:
        return "shoe.2"
    case Categories.car:
        return "car.2.fill"
    }
}
