//
//  aBookTextFields.swift
//  BookNoteFinal
//
//  Created by Maciej Daszkiewicz on 16/02/2024.
//

import SwiftUI

enum TextFieldFocus {
    case title, author, pages
}

struct aBookTextFields: View {
    @Binding var title: String
    @Binding var author: String
    @Binding var pageCount: Int
    @Binding var stringPageCount: String
    @FocusState var focus: TextFieldFocus?

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            
            AddBookTextField(titleKey: NSLocalizedString("Title", comment: ""), binding: $title)
                .focused($focus, equals: .title)
                .onTapGesture { checkEmptyString() }
            
            AddBookTextField(titleKey: NSLocalizedString("Author", comment: ""), binding: $author)
                .focused($focus, equals: .author)
                .onTapGesture { checkEmptyString() }
            
            aPagesTextField(focus: $focus, stringPageCount: $stringPageCount, title: $title, pageCount: $pageCount)
        }
        .keyboardType(.alphabet)
        .autocorrectionDisabled()
        .toolbar {
            ToolbarItem(placement: .keyboard) {
                Button {
                    focus = nil
                } label: {
                    Image("hideKeyboard_ICON")
                }.frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
    }
    
    func checkEmptyString() {
        if stringPageCount == "" {
            stringPageCount = "0"
        }
    }
}
