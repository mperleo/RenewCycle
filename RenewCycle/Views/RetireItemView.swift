//
//  NewTareaView.swift
//  TaskSwiftData
//
//  Created by Miguel Pérez León on 30/6/25.
//

import SwiftUI

struct RetireItemView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    
    let item: Item
    
    @State private var retirementDate: Date = Date()
    
    var body: some View {
        NavigationStack {
            Form {
                VStack(alignment: .leading) {
                        DatePicker("Fecha del cambio", selection: $retirementDate, displayedComponents: .date)
                }
            }
            .toolbar{
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        retireItem()
                    }label: {
                        Text("Guardar")
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
    
    private func retireItem() {
        item.retireItem(retirementDate: retirementDate)
        context.insert(item)
        dismiss()
    }
}
