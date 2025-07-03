//
//  NewTareaView.swift
//  TaskSwiftData
//
//  Created by Miguel Pérez León on 30/6/25.
//

import PhotosUI
import SwiftUI

struct NewItemView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context

    @State private var showConfirmation: Bool = false
    @State private var showImagePicker: Bool = false
    @State private var photoPickerItem: PhotosPickerItem?
    @State private var itemImage: Image?

    @State private var model: String = ""
    @State private var brand: String = ""
    @State private var purchaseDate: Date = Date()
    @State private var category: Categories = .technology
    @State private var price: String = ""
    @State private var image: Data = Data()
    @State private var receipt: Data = Data()

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
                    Section(header: Text("Item Dates")) {
                        DatePicker(
                            "Buy date",
                            selection: $purchaseDate,
                            displayedComponents: .date
                        )
                    }
                    Section(header: Text("Item image")) {
                        PhotosPicker("Select a photo", selection: $photoPickerItem, matching: .images) {
                            itemImage?.resizable().scaledToFit()
                        }
                    }
                }
            }
            .onChange(of: photoPickerItem) { _, _ in
                Task {
                    itemImage = try await photoPickerItem?.loadTransferable(
                        type: Image.self)
                }
            }
            .navigationTitle(Text("New Item"))
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        showConfirmation.toggle()
                    } label: {
                        Text("Save")
                    }.confirmationDialog(
                        "Are you sure you wanna add the item?",
                        isPresented: $showConfirmation,
                        titleVisibility: .visible
                    ) {
                        Button("Save", role: .destructive) {
                            addTask()
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

    private func addTask() {
        let priceDouble = Double(price) ?? 0
        let newItem = Item(
            id: UUID(),
            purchaseDate: purchaseDate,
            model: model,
            brand: brand,
            category: category,
            price: priceDouble,
            image: image,
            receipt: receipt
        )
        context.insert(newItem)
        dismiss()
    }
}

#Preview(traits: .sampledata) {
    NewItemView()
}
