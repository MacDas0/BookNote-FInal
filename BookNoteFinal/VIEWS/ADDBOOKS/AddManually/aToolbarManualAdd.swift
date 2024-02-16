//
//  aToolbarManualAdd.swift
//  BookNoteFinal
//
//  Created by Maciej Daszkiewicz on 16/02/2024.
//

import SwiftUI

struct aToolbarManualAdd: View {
    @EnvironmentObject var sharedData: SharedData
    let addToLibrary: () -> Void

    var body: some View {
        Text("")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button { addToLibrary() } label: { Image("tick_ICON") }
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button { sharedData.appState = .main } label: { Image("back_ICON") }
                }
            }
    }
}
