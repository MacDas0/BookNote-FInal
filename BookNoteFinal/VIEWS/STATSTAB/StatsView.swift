//
//  StatsView.swift
//  BookNoteFinal
//
//  Created by Maciej Daszkiewicz on 14/02/2024.
//

import SwiftUI

struct StatsView: View {
    @EnvironmentObject var sharedData: SharedData

    var body: some View {
        NavigationStack {
            VStack {
                Text("hi")
            }.globalBackground() .navigationTitle("Statistics")
            .toolbar {
                ToolbarItem {
                    Button { sharedData.appState = .more } label: { Image("more_ICON") }
                }
            }
        }
    }
}

#Preview {
    StatsView()
}
