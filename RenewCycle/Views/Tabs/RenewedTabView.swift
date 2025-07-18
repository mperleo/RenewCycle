//
//  RenewedTabView.swift
//  RenewCycle
//
//  Created by Miguel Pérez León on 18/7/25.
//

import SwiftUI
import SwiftData

struct RenewedTabView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item] = []
    
    @State private var showAdd = false
    @State private var searchText: String = ""
    
    private var filteredItems: [Item] {
        if searchText.isEmpty {
            return items
        } else {
            return items.filter {
                $0.model.lowercased().contains(searchText.lowercased())
                || $0.brand.lowercased().contains(searchText.lowercased())
            }
        }
    }
    
    private var renewedItems: [Item] {
        filteredItems.filter {
            $0.renewDate != nil
        }.sorted { $0.purchaseDate > $1.purchaseDate }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                if items.isEmpty {
                    ContentUnavailableView(
                        "No items",
                        systemImage: "ipad.landscape.and.iphone.slash",
                        description: Text("let's add some new items!")
                    )
                } else {
                    List {
                        if renewedItems.count > 0 {
                            ItemList(items: renewedItems, sectionLabel: "Renewed", itemCount: renewedItems.count)
                        }
                    }.searchable(text: $searchText)
                }
            }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        EditButton()
                    }
                }
        }
        .sheet(isPresented: $showAdd) {
            NewItemView()
        }
    }
    
    private func addItem() {
        withAnimation {
            showAdd.toggle()
        }
    }
    
}

#Preview(traits: .sampledata) {
    RenewedTabView()
}
