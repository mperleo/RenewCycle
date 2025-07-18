//
//  ContentView.swift
//  RenewCycle
//
//  Created by Miguel Pérez León on 1/7/25.
//

import SwiftData
import SwiftUI

struct ContentView: View {

    var body: some View {
        Group {
            NativeTabView()
        }

    }

    @ViewBuilder
    func NativeTabView() -> some View {
        TabView {
            Tab.init("Home", systemImage: "house.fill") {
                HomeTabView()
            }
            Tab.init("In use", systemImage: "list.bullet") {
                InUseTabView()
            }
            Tab.init("Renewed", systemImage: "checklist.checked") {
                RenewedTabView()
            }
        }
    }

}

#Preview(traits: .sampledata) {
    ContentView()
}
