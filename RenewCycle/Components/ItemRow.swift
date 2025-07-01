//
//  ItemRow.swift
//  RenewCycle
//
//  Created by Miguel Pérez León on 1/7/25.
//

import SwiftUI

struct ItemRow: View {
    let item: Item
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(item.model).font(.headline)
            HStack{
                Text(item.purchaseDate.formatted(date: .long, time: .omitted))
                Spacer()
                
                if item.retirementDate != nil {
                    Text("Renewed")
                    Text(String(item.getDaysBetweenPurchaseAndRetirement()) + " days")
                    
                }
                else {
                    Text(String(item.getDaysSincePurchase()) + " days")
                }
            }
            .font(.subheadline).foregroundStyle(.secondary)
        }
    }
}
