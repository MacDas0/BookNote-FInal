//
//  SharedData.swift
//  BookNoteFinal
//
//  Created by Maciej Daszkiewicz on 14/02/2024.
//

import Foundation
import UIKit

class SharedData: ObservableObject {
    let sampleBooks =  ["deepwork", "economicsfordummies", "fourthousandweeks", "meditations", "onhavingnohead", "sapiens", "themagicofthinkingbig", "thefourhourworkweek"]
    
    @Published var appState: AppState = .main
    
    func mainInit() {
        print(URL.applicationSupportDirectory.path(percentEncoded: false))
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.customDark
        appearance.shadowColor = UIColor.customDark
        let appearance2 = UITabBarAppearance()
        appearance2.configureWithOpaqueBackground()
        appearance2.backgroundColor = UIColor.customDark
        appearance2.shadowColor = UIColor.customDark
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UITabBar.appearance().standardAppearance = appearance2
        UITabBar.appearance().scrollEdgeAppearance = appearance2
    }
}
