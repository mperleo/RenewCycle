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
        VStack(alignment: .leading) {
            List {
                HStack {
                    Text(item.category.rawValue)
                    Image(systemName: getCategoryIcon(category: item.category))
                }
                Text(
                    "Comprado: "
                        + item.purchaseDate.formatted(
                            date: .long,
                            time: .omitted
                        )
                )
                Text("Usado: " + String(item.getDaysSincePurchase()) + " días")
            }.padding(.top, 10).navigationTitle(item.model)
        }
    }
}
