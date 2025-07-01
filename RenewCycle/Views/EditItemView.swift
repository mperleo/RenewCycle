//
//  NewTareaView.swift
//  TaskSwiftData
//
//  Created by Miguel Pérez León on 30/6/25.
//

import SwiftUI

struct EditItemView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context

    let item: Item

    @State private var model: String
    @State private var brand: String
    @State private var purchaseDate: Date
    @State private var retirementDate: Date
    @State private var category: Categories
    @State private var price: String
    
    init( item: Item) {
        self.item = item
        self.model = item.model
        self.brand = item.brand
        self.purchaseDate = item.purchaseDate
        self.retirementDate = item.retirementDate ?? Date()
        self.category = item.category
        self.price = String(item.price)
    }

    var body: some View {
        NavigationStack {
            Form {
                List {
                    TextField("Model", text: $model).padding(.top, 10)
                    TextField("Brand", text: $brand).padding(.top, 10)
                    TextField("Price", text: $price).padding(.top, 10)
                    DatePicker(
                        "Buy date",
                        selection: $purchaseDate,
                        displayedComponents: .date
                    ).padding(.top, 10)
                    DatePicker(
                        "Renewed date",
                        selection: $retirementDate,
                        displayedComponents: .date
                    ).padding(.top, 10)
                    Picker(selection: $category) {
                        ForEach(Categories.allCases) { category in
                            Text(category.rawValue)
                        }
                    } label: {
                        Text("Categoría")
                    }.padding(.top, 10)
                }
            }
            .navigationTitle(Text("Edit Item"))
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        editTask()
                    } label: {
                        Text("Add")
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.backward")
                        Text("Cancel")
                    }
                }
            }
        }
    }

    private func editTask() {
        item.model = model
        item.brand = brand
        item.purchaseDate = purchaseDate
        item.retirementDate = retirementDate
        item.category = category
        item.price = Double(price) ?? 0
        
        context.insert(item)
        dismiss()
    }
}

#Preview(traits: .sampledata) {
    let item1 = Item(
        id: UUID(),
        purchaseDate: .now,
        model: "macbook",
        brand: "apple",
        category: Categories.technology,
        price: 1600.99
    )
    EditItemView(item: item1)
}
