//
//  MainTabView.swift
//  BookNoteFinal
//
//  Created by Maciej Daszkiewicz on 14/02/2024.
//

import SwiftUI


struct MainTabView: View {
    @EnvironmentObject var tabData: MainTabBarData
    @EnvironmentObject var dataController: DataController

    var body: some View {
        TabView(selection: $tabData.itemSelected) {
            
            HomeView().tabItem { TabIcon(tag: 1, iconFilled: "home_FILL_ICON", iconBasic: "home_ICON", text: "Home") }
                .tag(1)
            
            BooksView().tabItem { TabIcon(tag: 2, iconFilled: "book_FILL_ICON", iconBasic: "book_ICON", text: "Books") }
                .tag(2)
            
            TestView.tabItem { Image("new_note_TAB").accessibilityLabel("plus") }
                .tag(3)
            
            NotesView().tabItem { TabIcon(tag: 4, iconFilled: "notes_FILL_ICON", iconBasic: "notes_ICON", text: "Notes") }
                .tag(4)
            
            StatsView().tabItem { TabIcon(tag: 5, iconFilled: "stats_FILL_ICON", iconBasic: "stats_ICON", text: "Stats") }
                .tag(5)

        }
        .sheet(isPresented: $tabData.isCustomItemSelected) {
            Text("NOTE VIEW")
        }
        .onAppear {
            dataController.deleteEmptyNotes()
//                dataController.deleteAll()
//                dataController.createSampleData()
        }
    }
    // show old view for split second when you click on the "fake" tab bar button
    private var TestView: some View {
        switch tabData.itemSelected {
        case 1:
            return AnyView(HomeView())
        case 2:
            return AnyView(BooksView())
        case 4:
            return AnyView(NotesView())
        case 5:
            return AnyView(StatsView())
        default:
            return AnyView(HomeView())
        }
    }
}

extension MainTabView {
    struct TabIcon: View {
        @EnvironmentObject var tabData: MainTabBarData
        let tag: Int
        let iconFilled: String
        let iconBasic: String
        let text: String

        var body: some View {
            VStack {
                Image(tabData.itemSelected == tag  ? iconFilled : iconBasic).accessibilityLabel(text)
                Text(text)
            }
        }
    }
}
