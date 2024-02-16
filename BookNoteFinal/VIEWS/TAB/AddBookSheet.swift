//
//  AddBookSheet.swift
//  BookNoteFinal
//
//  Created by Maciej Daszkiewicz on 14/02/2024.
//

import SwiftUI

enum BookAction {
    case searchOnline, addFromKindle, scanBarcode, addManually
}

struct AddBookSheet: View {
    @EnvironmentObject var tabData: MainTabBarData
    @EnvironmentObject var sharedData: SharedData

    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button {
                    handleAction(.searchOnline)
                } label: {
                    ButtonLabel(image: "searchBook_ICON", text: "Search online")
                }
                Spacer()
                Button {
                    handleAction(.scanBarcode)
                } label: {
                    ButtonLabel(image: "scan_ICON", text: "Scan barcode")
                }
                Spacer()
                Button {
                    handleAction(.addManually)
                } label: {
                    ButtonLabel(image: "manualAdd_ICON", text: "Add manually")
                }
                Spacer()
            }
        }.frame(maxHeight: .infinity) .background(Color.customLightDark) .presentationDetents([.height(250)])
        .onDisappear { tabData.dismissCustomItemSheet() }
    }
    private func handleAction(_ action: BookAction) {
        tabData.dismissCustomItemSheet()
        switch action {
        case .searchOnline:
            sharedData.appState = .searchOnline
        case .addFromKindle:
            sharedData.appState = .addFromKindle
        case .scanBarcode:
            sharedData.appState = .scanBarcode
        case .addManually:
            sharedData.appState = .addManually
        }
    }
}

extension AddBookSheet {
    struct ButtonLabel: View {
        let image: String
        let text: String
        
        var body: some View {
            Image(image).font(.largeTitle) .frame(width: 120, height: 120).accessibilityHidden(true).fontWeight(.ultraLight)
                .background(
                    Text(LocalizedStringKey(text)) .multilineTextAlignment(.center) .padding(.top, 80) .font(.popSecondary)
                )
        }
    }}
