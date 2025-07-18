//
//  HomeView.swift
//  RenewCycle
//
//  Created by Miguel Pérez León on 18/7/25.
//

import SwiftData
import SwiftUI

struct HomeView: View {
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
    
    private var inUseItems: [Item] {
        filteredItems.filter {
            $0.renewDate == nil
        }.sorted { $0.purchaseDate > $1.purchaseDate }
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
                        if inUseItems.count > 0 {
                            ItemList(items: inUseItems, sectionLabel: String("In use"))
                        }
                        
                        if renewedItems.count > 0 {
                            ItemList(items: renewedItems, sectionLabel: "Renewed")
                        }
                    }.searchable(text: $searchText)
                }
            }.navigationTitle("RenewCycle")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        EditButton()
                    }
                    ToolbarItem {
                        Button(action: addItem) {
                            Label("Add Item", systemImage: "plus")
                        }
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
    ContentView()
}
