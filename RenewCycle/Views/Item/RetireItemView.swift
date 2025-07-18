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
    @State private var showConfirmation: Bool = false

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Renew date")) {
                    VStack(alignment: .leading) {
                        DatePicker(
                            "Renew date",
                            selection: $retirementDate,
                            displayedComponents: .date
                        )
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button {
                        showConfirmation.toggle()
                    } label: {
                        Text("Save")
                    }.confirmationDialog(
                        "Are you sure you wanna renew the item?",
                        isPresented: $showConfirmation,
                        titleVisibility: .visible
                    ) {
                        Button("Renew", role: .destructive) {
                            reNewItem()
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

    private func reNewItem() {
        item.renewItem(renewDate: retirementDate)
        context.insert(item)
        dismiss()
    }
}
