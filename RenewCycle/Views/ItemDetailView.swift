//
//  ItemDetail.swift
//  RenewCycle
//
//  Created by Miguel Pérez León on 1/7/25.
//

import SwiftUI

struct ItemDetailView: View {
    let item: Item

    @State private var showRetire = false

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                List {
                    HStack {
                        Text(item.category.rawValue)
                        Image(
                            systemName: getCategoryIcon(category: item.category)
                        )
                    }
                    Text(
                        "Comprado: "
                            + item.purchaseDate.formatted(
                                date: .long,
                                time: .omitted
                            )
                    )
                    Text(
                        "Precio: "
                        + String(item.price)
                    )
                    Text(
                        "Usado: " + String(item.getDaysSincePurchase())
                            + " días"
                    )
                    if item.retirementDate != nil {
                        Text("Cambiado: "
                             + (item.retirementDate?.formatted(
                                date: .long,
                                time: .omitted
                             ) ?? "0"))
                    }
                }.padding(.top, 10).navigationTitle(item.model).toolbar {
                    ToolbarItem {
                        Button(action: retireItem) {
                            Label(
                                "Cambiar",
                                systemImage:
                                    "rectangle.portrait.and.arrow.right.fill"
                            )
                        }
                    }
                }
            }
        }.fullScreenCover(isPresented: $showRetire) {
            RetireItemView(item: item)
        }
    }

    private func retireItem() {
        withAnimation {
            showRetire.toggle()
        }
    }
}
