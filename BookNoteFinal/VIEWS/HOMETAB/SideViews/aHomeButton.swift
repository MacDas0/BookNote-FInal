//
//  aHomeButton.swift
//  BookNoteFinal
//
//  Created by Maciej Daszkiewicz on 14/02/2024.
//

import SwiftUI

struct aHomeButton: View {
    let action: () -> Void
    let text: String
    let image: String
    var body: some View {
        Button {
            action()
        } label: {
            RoundedRectangle(cornerRadius: 10, style: .continuous).fill(Color.customLightDark).frame(width: 150, height: 100)
                .overlay(
                    VStack {
                        Text(text).font(.popMid).padding(.horizontal)
                        Image(image).font(.system(size: 30)).padding(4).fontWeight(.ultraLight)
                    }.foregroundStyle(.white)
                )
        }.padding(.horizontal)
    }
}

