//
//  AppStateView.swift
//  BookNoteFinal
//
//  Created by Maciej Daszkiewicz on 14/02/2024.
//

import SwiftUI

enum AppState {
    case main, note, more ,searchOnline, addFromKindle, scanBarcode, addManually
}

struct AppStateView: View {
    @EnvironmentObject var sharedData: SharedData
    @EnvironmentObject var dataController: DataController

    var body: some View {
        Group {
            switch sharedData.appState {
            case .main:
                MainTabView()
            case .note:
                Text("note")
            case .more:
                MoreView()
            case .searchOnline:
                SearchOnlineView()
            case .addFromKindle:
               Text("kindle")
            case .scanBarcode:
                ScanBarcodeView()
            case .addManually:
                AddManuallyView()
            }
        }
        .onAppear {
            dataController.deleteEmptyNotes()
            dataController.deleteAll()
            dataController.createSampleData()
        }
    }
}
