//
//  BookNoteFinalApp.swift
//  BookNoteFinal
//
//  Created by Maciej Daszkiewicz on 14/02/2024.
//

import SwiftUI

@main
struct BookNoteFinalApp: App {
    @StateObject var dataController = DataController()
    @StateObject var sharedData = SharedData()
    @StateObject var tabData = MainTabBarData(initialIndex: 1, customItemIndex: 3)

    var body: some Scene {
        WindowGroup {
            Group {
                AppStateView()
            }.preferredColorScheme(.dark) .tint(.white) .scrollContentBackground(.hidden) .font(.popMid) .fontWeight(.thin)
                .environmentObject(tabData)
                .environmentObject(sharedData)
                .environmentObject(dataController)
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
    
    init() {
        SharedData().mainInit()
    }
}
