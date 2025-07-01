//
//  Item.swift
//  RenewCycle
//
//  Created by Miguel Pérez León on 30/6/25.
//

import Foundation
import SwiftData

@Model
final class Item {
    @Attribute(.unique) var id: UUID
    var purchaseDate: Date
    var retirementDate: Date?
    var model: String
    var brand: String
    var category: Categories
    var price: Double
    
    init(id: UUID, purchaseDate: Date, model: String, brand: String, category: Categories, price: Double) {
        self.purchaseDate = purchaseDate
        self.model = model
        self.brand = brand
        self.category = category
        self.price = price
        self.id = id
    }
    
    public func retireItem(retirementDate: Date) {
        self.retirementDate = retirementDate
    }
    
    public func getDaysSincePurchase() -> Int {
        let components = Calendar.current.dateComponents([.day], from: purchaseDate, to: Date())
        return components.day ?? 0
    }
    
    public func getDaysBetweenPurchaseAndRetirement() -> Int {
        guard let retirementDate = retirementDate else {
            return 0
        }
        let components = Calendar.current.dateComponents([.day], from: purchaseDate, to: retirementDate)
        return components.day ?? 0
    }
}
