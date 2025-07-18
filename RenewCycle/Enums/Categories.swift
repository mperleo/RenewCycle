//
//  Categorias.swift
//  RenewCycle
//
//  Created by Miguel Pérez León on 1/7/25.
//

import Foundation

enum Categories: String, Codable, CaseIterable, Identifiable {
    case technology = "Electronics"
    case clothing = "Fashion"
    case car = "Car"
    case bikes = "Bikes"
    case phones = "Phones"
    case watches = "Watches"
    case videoGames = "Video Games"
    case computers = "Computers"
    case cameras = "Cameras"
    case headphones = "Headphones"
    case tablets = "Tablets"
    case fitnessAndHealth = "Fitness & Health"
    case homeAndKitchen = "Home & Kitchen"
    
    var id: Self { self }
}

func getCategoryIcon(category: Categories) -> String {
    switch category {
    case Categories.technology:
        return "macbook.and.iphone"
    case Categories.clothing:
        return "shoe.2"
    case Categories.car:
        return "car.2.fill"
    case Categories.bikes:
        return "bicycle"
    case Categories.phones:
        return "iphone.gen1"
    case Categories.watches:
        return "watch.analog"
    case Categories.videoGames:
        return "gamecontroller"
    case Categories.computers:
        return "macpro.gen1"
    case Categories.cameras:
        return "camera"
    case Categories.headphones:
        return "airpods.max"
    case Categories.tablets:
        return "ipad.gen1"
    case Categories.fitnessAndHealth:
        return "figure.run"
    case Categories.homeAndKitchen:
        return "house"
    }
}
