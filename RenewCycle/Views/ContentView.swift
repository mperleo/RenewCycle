//
//  ContentView.swift
//  RenewCycle
//
//  Created by Miguel Pérez León on 1/7/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    
    @Query private var items: [Item] = []
    
    @State private var showAdd = false
    
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
            ForEach(items) { item in
                NavigationLink {
                    ItemDetailView(item: item)
                }label: {
                    ItemRow(item: item)
                }
            }.onDelete(perform: deleteItems)
        }
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
