//
//  aHomeButtons.swift
//  BookNoteFinal
//
//  Created by Maciej Daszkiewicz on 14/02/2024.
//

import SwiftUI

struct aHomeButtons: View {
    @State private var showNewBookSheet = false
    var body: some View {
        HStack(alignment: .center) {
            aHomeButton(action: { }, text: "Note Revision", image: "note_ICON")
            aHomeButton(action: { showNewBookSheet.toggle() }, text: "New Book", image: "book2_ICON")
        }.frame(maxWidth: .infinity, alignment: .center) .padding(.top)
        .sheet(isPresented: $showNewBookSheet) {
            AddBookSheet()
        }
    }
}

#Preview {
    aHomeButtons()
}
