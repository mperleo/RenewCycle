//
//  SampleData.swift
//  TaskSwiftData
//
//  Created by Miguel Pérez León on 30/6/25.
//

import SwiftData
import SwiftUI

struct SampleData: PreviewModifier {

    static func makeSharedContext() async throws -> ModelContainer {
        let schema = Schema([
            Item.self
        ])
        let modelConfiguration = ModelConfiguration(
            schema: schema,
            isStoredInMemoryOnly: true
        )

        let container = try ModelContainer(
            for: schema,
            configurations: [modelConfiguration]
        )

        let item1 = Item( id: UUID(), purchaseDate: .now, model: "macbook", brand: "apple", category: Categories.technology, price: 1600.99)
        let item2 = Item( id: UUID(), purchaseDate: Date.distantPast, model: "iphone 13", brand: "apple", category: Categories.technology, price: 1099.99)
        
        item2.renewItem(renewDate: Date.now)
        
        container.mainContext.insert(item1)
        container.mainContext.insert(item2)

        return container
    }

    func body(content: Content, context: ModelContainer) -> some View {
        content.modelContainer(context)
    }
}

extension PreviewTrait where T == Preview.ViewTraits {
    @MainActor
    static var sampledata: Self = .modifier(SampleData())
}
