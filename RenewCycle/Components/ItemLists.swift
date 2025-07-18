//
//  ItemLists.swift
//  RenewCycle
//
//  Created by Miguel Pérez León on 18/7/25.
//

import SwiftData
import SwiftUI

struct ItemList: View {
    @Environment(\.modelContext) private var modelContext

    let items: [Item]
    let sectionLabel: String
    let itemCount: Int

    var body: some View {
        Section(header: Text(sectionLabel + " (" + String(itemCount) + ")")) {
            ForEach(items) { item in
                NavigationLink {
                    ItemDetailView(item: item)
                } label: {
                    ItemRow(item: item)
                }
            }.onDelete(perform: deleteItems)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}
