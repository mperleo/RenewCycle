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
    var launchDate: Date
    var notes: String
    var model: String
    var brand: String
    var category: Categories
    var price: Double

    init(
        id: UUID,
        purchaseDate: Date,
        launchDate: Date,
        model: String,
        brand: String,
        category: Categories,
        notes: String,
        price: Double
    ) {
        self.purchaseDate = purchaseDate
        self.launchDate = launchDate
        self.notes = notes
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

    public func getUsageStringInYearsAndDays(sincePurchase: Bool = false) -> String {
        var  totalDaysUsed =
        self.renewDate == nil || sincePurchase
        ?  getDaysSincePurchase(): getDaysBetweenPurchaseAndRetirement()
        
        totalDaysUsed = totalDaysUsed == 0 ? 1 : totalDaysUsed

        let yearsUsed = totalDaysUsed / 365
        let daysUsed = totalDaysUsed % 365

        return getStringYearsDays(years: yearsUsed, days: daysUsed)
    }
    
    public func getDaysSinceRelease() -> Int {
        let components = Calendar.current.dateComponents(
            [.day],
            from: launchDate,
            to: Date()
        )
        return components.day ?? 0
    }
    
    public func getTimeSinceLaunchStringInYearsAndDays() -> String {
        var totalDays = getDaysSinceRelease()
        
        totalDays = totalDays == 0 ? 1 : totalDays
        
        let years = totalDays / 365
        let days = totalDays % 365
        
        return getStringYearsDays(years: years, days: days)
    }
    
    private func getStringYearsDays(years: Int, days: Int) -> String {
        return
            "\(years > 0 ? String(years) + " " + String(localized: "years") : "" ) \(days > 0 ? String(days) + " " + String(localized: "days") : "")"
    }
}
