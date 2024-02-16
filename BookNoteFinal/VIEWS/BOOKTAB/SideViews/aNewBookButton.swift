//
//  aNewBookButton.swift
//  BookNoteFinal
//
//  Created by Maciej Daszkiewicz on 14/02/2024.
//

import SwiftUI

struct aNewBookButton: View {
    @State private var showNewBookSheet = false
    
    var body: some View {
        Button {
            showNewBookSheet.toggle()
        } label: {
            ZStack {
                RoundedRectangle(cornerRadius: 10, style: .continuous).fill(Color.customLightDark) .frame(width: 100, height: 150)
                Image("plus_ICON").font(.system(size: 40))
            }
        }
        .sheet(isPresented: $showNewBookSheet) {
            AddBookSheet()
        }
    }
}
