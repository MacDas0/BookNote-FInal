//
//  aSearchBookTextField.swift
//  BookNoteFinal
//
//  Created by Maciej Daszkiewicz on 16/02/2024.
//

import SwiftUI

extension SearchOnlineView {
    struct aSearchBookTextField: View {
        @EnvironmentObject var googleBooks: GoogleBooks
        @Binding var searchText: String
        
        var body: some View {
            TextField("Search Books", text: $searchText)
                .padding(8)
                .padding(.vertical, 5)
                .background(Color.customLightDark)
                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                .padding(.horizontal)
                .submitLabel(.search)
                .onSubmit {
                    googleBooks.searchBooks(searchTerm: searchText)
                }
        }
    }
}
