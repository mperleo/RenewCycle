//
//  NewTareaView.swift
//  TaskSwiftData
//
//  Created by Miguel Pérez León on 30/6/25.
//

import SwiftUI

struct NewItemView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    @State private var model: String = ""
    @State private var brand: String = ""
    @State private var purchaseDate: Date = Date()
    @State private var category: Categories = .technology
    @State private var price: String = ""
    
    var body: some View {
        NavigationStack {
            Form {
                VStack(alignment: .leading) {
                    TextField("Modelo", text: $model).padding(.top, 10)
                    TextField("Marca", text: $brand).padding(.top, 10)
                    TextField("Precio", text: $price).padding(.top, 10)
                    DatePicker("Fecha de la Tarea", selection: $purchaseDate, displayedComponents: .date).padding(.top, 10)
                    Picker(selection: $category) {
                        ForEach(Categories.allCases) { category in
                            Text(category.rawValue)
                        }
                    } label: {
                        Text("Categoría")
                    }.padding(.top, 10)
                }
            }
            .navigationTitle(Text("Nuevo Item"))
            .toolbar{
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        addTask()
                    }label: {
                        Text("Añadir")
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        dismiss()
                    }label: {
                        Image(systemName: "chevron.backward")
                        Text("Cancelar")
                    }
                }
            }
        }
    }
    
    private func addTask() {
        let priceDouble = Double(price) ?? 0
        let newItem = Item(id: UUID(), purchaseDate: purchaseDate, model: model, brand: brand, category: category, price: priceDouble)
        context.insert(newItem) 
        dismiss()
    }
}

#Preview(traits: .sampledata) {
    NewItemView()
}
