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
    var renewDate: Date?
    var model: String
    var brand: String
    var category: Categories
    var price: Double

    init(
        id: UUID,
        purchaseDate: Date,
        model: String,
        brand: String,
        category: Categories,
        price: Double
    ) {
        self.purchaseDate = purchaseDate
        self.model = model
        self.brand = brand
        self.category = category
        self.price = price
        self.id = id
    }

    public func renewItem(renewDate: Date) {
        self.renewDate = renewDate
    }

    public func getDaysSincePurchase() -> Int {
        let components = Calendar.current.dateComponents(
            [.day],
            from: purchaseDate,
            to: Date()
        )
        return components.day ?? 0
    }

    public func getDaysBetweenPurchaseAndRetirement() -> Int {
        guard let retirementDate = renewDate else {
            return 0
        }
        let components = Calendar.current.dateComponents(
            [.day],
            from: purchaseDate,
            to: retirementDate
        )
        return components.day ?? 0
    }

    public func getUsageStringInYearsAndDays() -> String {
        let totalDaysSincePurchase: Int = getDaysSincePurchase()
        let totalDaysUntilRenew: Int = getDaysBetweenPurchaseAndRetirement()

        let yearsSincePurchase = totalDaysSincePurchase / 365
        var daysSincePurchase = totalDaysSincePurchase % 365

        let yearsUntilRenew = totalDaysUntilRenew / 365
        let daysUntilRenew = totalDaysUntilRenew % 365

        if totalDaysUntilRenew > 0 {
            return
                "\(yearsUntilRenew > 0 ? String(yearsUntilRenew) + " years" : "" ) \(daysUntilRenew > 0 ? String(daysUntilRenew) + " days" : "")"
        } else {
            daysSincePurchase = daysSincePurchase == 0 ? 1 : daysSincePurchase

            return
                "\(yearsSincePurchase > 0 ? String(yearsSincePurchase) + " years" : "" ) \(daysSincePurchase > 0 ? String(daysSincePurchase) + " days" : "")"
        }
    }
}
