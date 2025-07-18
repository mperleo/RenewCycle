//
//  ItemDetail.swift
//  RenewCycle
//
//  Created by Miguel Pérez León on 1/7/25.
//

import SwiftUI

struct ItemDetailView: View {
    @State private var showRetire = false
    @State private var showEdit = false
    let item: Item

    var body: some View {
        NavigationStack {
            List {
                ItemDetail(item: item).padding(.top, 10)
            }
            .navigationTitle(item.model)
            .toolbar {
                ToolbarItem {
                    Button(action: editItem) {
                        Label("Edit Item", systemImage: "pencil")
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        retireItem()
                    } label: {
                        Text("Renew")
                    }
                }
            }
        }.sheet(isPresented: $showRetire) {
            RetireItemView(item: item)
        }.sheet(isPresented: $showEdit) {
            EditItemView(item: item)
        }
    }

    private func retireItem() {
        withAnimation {
            showRetire.toggle()
        }
    }

    private func editItem() {
        withAnimation {
            showEdit.toggle()
        }
    }
}

#Preview(traits: .sampledata) {
    let item1 = Item(
        id: UUID(),
        purchaseDate: .now,
        launchDate: .now,
        model: "macbook",
        brand: "apple",
        category: Categories.technology,
        notes: "sample",
        price: 1600.99
    )
    ItemDetailView(item: item1)
}
