//
//  aPagesTextField.swift
//  BookNoteFinal
//
//  Created by Maciej Daszkiewicz on 16/02/2024.
//

import SwiftUI

struct aPagesTextField: View {
//    @FocusState private var focusOnTextField: Bool
    var focus: FocusState<TextFieldFocus?>.Binding
    @Binding var stringPageCount: String
    @Binding var title: String
    @Binding var pageCount: Int
    
    
    var body: some View {
        ZStack(alignment: .leading) {
            TextField("", text: $title).disabled(true) .opacity(0) .padding() .background(Color.customLightDark.clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous)))
            HStack(alignment: .firstTextBaseline) {
                TextField("", text: $stringPageCount)
                    .focused(focus, equals: .pages)
                    .keyboardType(.numberPad)
                    .fixedSize()
                    .onAppear { stringPageCount = String(pageCount) }
                Text("pages").foregroundColor(.gray) .font(.popMini)
            }.padding(.horizontal)
        }
        .onChange(of: stringPageCount) {
            pageCount = Int(stringPageCount) ?? 0
        }
        .onTapGesture {
            focus.wrappedValue = .pages
        }
    }
}

