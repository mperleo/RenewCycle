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
                HomeView()
            }
            Tab.init("Lists", systemImage: "list.bullet") {
                HomeView()
            }
            Tab.init("Lists", systemImage: "list.bullet") {
                HomeView()
            }
        }
    }

}

#Preview(traits: .sampledata) {
    ContentView()
}
