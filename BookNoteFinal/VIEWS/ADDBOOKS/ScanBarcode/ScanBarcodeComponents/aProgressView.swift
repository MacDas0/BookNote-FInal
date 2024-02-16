//
//  aProgressView.swift
//  BookNoteFinal
//
//  Created by Maciej Daszkiewicz on 16/02/2024.
//

import SwiftUI

struct aProgressView: View {
    @EnvironmentObject var sharedData: SharedData
    @EnvironmentObject var googleBooks: GoogleBooks
    let failMessage = "Sorry, we could not find any books with this ISBN :("

    var body: some View {
        ProgressView().progressViewStyle(CircularProgressViewStyle()) .scaleEffect(1.5)
            .globalBackground()
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button { sharedData.appState = .main } label: { Image("back_ICON").accessibilityLabel("back") }
                }
            }
            .alert(failMessage, isPresented: $googleBooks.fail) {
                Button("OK") { sharedData.appState = .main }
            }
    }
}

