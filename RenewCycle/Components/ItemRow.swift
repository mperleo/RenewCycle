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
            HStack {
                Text(item.model).font(.headline)
                Text(item.brand).font(.subheadline)
                Spacer()
                if item.renewDate != nil {
                    Text("Renewed")
                }
            }

            HStack {
                Text(item.purchaseDate.formatted(date: .long, time: .omitted))
                Spacer()
                Text(item.getUsageStringInYearsAndDays())
            }
            .font(.subheadline).foregroundStyle(.secondary)
        }
    }
}
