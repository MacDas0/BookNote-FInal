//
//  HomeView.swift
//  BookNoteFinal
//
//  Created by Maciej Daszkiewicz on 14/02/2024.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var sharedData: SharedData

    var body: some View {
        NavigationStack {
            GeometryReader { geo in
                ScrollView {
                    VStack(spacing: 20) {
                        aHomeButtons()
                        
                        aLastOpenedBooks()
                        
                        aRecommendedBooks()
                    }
                }
            }.globalBackground() .navigationTitle("BookNote")
            .toolbar {
                ToolbarItem {
                    Button {
                        sharedData.appState = .more
                    } label: {
                        Image("more_ICON")
                    }
                }
            }
        }
    }
}

#Preview {
    HomeView()
        .preferredColorScheme(.dark)
        .environmentObject(SharedData())
}
