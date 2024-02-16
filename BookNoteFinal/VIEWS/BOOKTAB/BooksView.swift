//
//  BooksView.swift
//  BookNoteFinal
//
//  Created by Maciej Daszkiewicz on 14/02/2024.
//

import SwiftUI

struct BooksView: View {
    @EnvironmentObject var dataController: DataController
    @EnvironmentObject var sharedData: SharedData
    
    let columns = [ GridItem(.adaptive(minimum: 80), spacing: 40) ]

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 40) {
                    aNewBookButton()
                    ForEach(dataController.filteredBooks()) { book in
                        NavigationLink {
                            BookView(book: book)
                        } label: {
                            allImageTypesView(height: 150, book: book)
                        }
                    }
                }.padding()
            }
            .globalBackground() .navigationTitle("Books")
            .searchable(text: $dataController.searchText, prompt: Text("Search"))
            .toolbar {
                ToolbarItem {
                    Button { sharedData.appState = .more } label: { Image("more_ICON") }
                }
            }
        }
    }
}

#Preview {
    BooksView()
        .preferredColorScheme(.dark)
        .environmentObject(DataController())
}
