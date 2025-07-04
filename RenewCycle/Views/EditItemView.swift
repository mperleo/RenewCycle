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

    @State private var showConfirmation: Bool = false
    @State private var model: String
    @State private var brand: String
    @State private var purchaseDate: Date
    @State private var category: Categories
    @State private var price: String

    @State private var retirementDate: Date
    @State private var showRenewDate: Bool = false

    init(item: Item) {
        self.item = item
        self.model = item.model
        self.brand = item.brand
        self.purchaseDate = item.purchaseDate
        self.retirementDate = item.renewDate ?? Date()
        self.showRenewDate = item.renewDate != nil
        self.category = item.category
        self.price = String(item.price)
    }

    var body: some View {
        NavigationStack {
            Form {
                List {
                    Section(header: Text("Item information")) {
                        TextField("Model", text: $model).padding(.top, 10)
                        TextField("Brand", text: $brand).padding(.top, 10)
                        TextField("Price", text: $price).padding(.top, 10)
                        Picker(selection: $category) {
                            ForEach(Categories.allCases) { category in
                                Text(category.rawValue)
                            }
                        } label: {
                            Text("Category")
                        }
                    }
                    Section(header: Text("Buy date")) {
                        DatePicker(
                            "Buy date",
                            selection: $purchaseDate,
                            displayedComponents: .date
                        )
                    }
                    Section(header: Text("Renew date")) {
                        Toggle("Renewed", isOn: $showRenewDate)
                        if showRenewDate {
                            DatePicker(
                                "Renew date",
                                selection: $retirementDate,
                                displayedComponents: .date
                            )
                        }
                    }
                }
            }
            .navigationTitle(Text("Edit \(item.model)"))
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        showConfirmation.toggle()
                    } label: {
                        Text("Save")
                    }.confirmationDialog(
                        "Are you sure you wanna save this changes?",
                        isPresented: $showConfirmation,
                        titleVisibility: .visible
                    ) {
                        Button("Save", role: .destructive) {
                            editTask()
                        }
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
        item.renewDate = showRenewDate ? retirementDate : item.renewDate
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
