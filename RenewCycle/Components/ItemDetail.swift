//
//  ItemDetail.swift
//  RenewCycle
//
//  Created by Miguel Pérez León on 1/7/25.
//

import SwiftUI

struct ItemDetail: View {
    let item: Item

    var body: some View {
        HStack {
            Text(item.category.rawValue).bold()
            Image(
                systemName: getCategoryIcon(category: item.category)
            )
        }
        HStack {
            Text("Buy date ")
            Spacer()
            Text(
                item.purchaseDate.formatted(
                    date: .long,
                    time: .omitted
                )
            ).bold()
        }
        
        HStack {
            Text("Price")
            Spacer()
            Text(
                String(item.price) + "€"
            ).bold()
        }
        
        if item.renewDate != nil {
            HStack {
                Text("Used")
                Spacer()
                Text(
                    String(item.getDaysBetweenPurchaseAndRetirement())
                    + " days"
                ).bold()
            }
            HStack {
                Text("Renew date")
                Spacer()
                Text(
                    (item.renewDate?.formatted(
                        date: .long,
                        time: .omitted
                    ) ?? "0")
                ).bold()
            }
        }
        else {
            HStack {
                Text("Used")
                Spacer()
                Text(
                    String(item.getDaysSincePurchase())
                    + " days"
                ).bold()
            }
        }
    }
}

#Preview(traits: .sampledata) {
    let item1 = Item(
        id: UUID(),
        purchaseDate: .now,
        model: "macbook",
        brand: "apple",
        category: Categories.technology,
        price: 1600.99
    )
    ItemDetail(item: item1)
}
