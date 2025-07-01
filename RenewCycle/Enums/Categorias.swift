//
//  Categorias.swift
//  RenewCycle
//
//  Created by Miguel Pérez León on 1/7/25.
//

import Foundation

enum Categorias: String, Codable, CaseIterable, Identifiable {
    case technology = "Technology"
    case sports = "Sports"
    case clothing = "Clothing"
    case car = "Car"
    
    var id: Self { self }
}
