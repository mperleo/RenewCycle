//
//  ContentView.swift
//  RenewCycle
//
//  Created by Miguel Pérez León on 1/7/25.
//

import SwiftData
import SwiftUI

struct ContentView: View {
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
                    main
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
        .fullScreenCover(isPresented: $showAdd) {
            NewItemView()
        }
    }

    var main: some View {
        List {
            if inUseItems.count > 0 {
                Section(header: Text("In use (" + String(inUseItems.count) + ")")) {
                    ForEach(inUseItems) { item in
                        NavigationLink {
                            ItemDetailView(item: item)
                        } label: {
                            ItemRow(item: item)
                        }
                    }.onDelete(perform: deleteItems)
                }
            }

            if renewedItems.count > 0 {
                Section(header: Text("Renewed (" + String(renewedItems.count) + ")")) {
                    ForEach(renewedItems) { item in
                        NavigationLink {
                            ItemDetailView(item: item)
                        } label: {
                            ItemRow(item: item)
                        }
                    }.onDelete(perform: deleteItems)
                }
            }
        }.searchable(text: $searchText)
    }

    private func addItem() {
        withAnimation {
            showAdd.toggle()
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

#Preview(traits: .sampledata) {
    ContentView()
}
