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
            Text("Category")
            Spacer()
            Text(item.category.rawValue).bold()
            Image(
                systemName: getCategoryIcon(category: item.category)
            )
        }.padding(.bottom, 10)
        
        HStack {
            Text("Brand")
            Spacer()
            Text(
                item.brand
            ).bold()
        }.padding(.bottom, 10)
        
        HStack {
            Text("Buy date")
            Spacer()
            Text(
                item.purchaseDate.formatted(
                    date: .long,
                    time: .omitted
                )
            ).bold()
        }.padding(.bottom, 10)
        
        HStack {
            Text("Price")
            Spacer()
            Text(
                String(item.price) + "€"
            ).bold()
        }.padding(.bottom, 10)
        
        HStack {
            Text("Used")
            Spacer()
            Text(item.getUsageStringInYearsAndDays()).bold()
        }.padding(.bottom, 10)
        
        if item.renewDate != nil {
            HStack {
                Text("Renew date")
                Spacer()
                Text(
                    (item.renewDate?.formatted(
                        date: .long,
                        time: .omitted
                    ) ?? "0")
                ).bold()
            }.padding(.bottom, 10)
            
            HStack {
                Text("Since purchase")
                Spacer()
                Text(item.getUsageStringInYearsAndDays(sincePurchase: true)).bold()
            }.padding(.bottom, 10)
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
