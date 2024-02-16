//
//  AddBookTextField.swift
//  BookNote
//
//  Created by Maciej Daszkiewicz on 10/01/2024.
//

import SwiftUI

struct AddBookTextField: View {
    let titleKey: String
    @Binding var binding: String

    var body: some View {
        TextField(titleKey, text: $binding).font(.popMid) .padding() .background(Color.customLightDark.clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous)))
    }
}

