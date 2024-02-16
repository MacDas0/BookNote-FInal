//
//  aLastOpenedBooks.swift
//  BookNoteFinal
//
//  Created by Maciej Daszkiewicz on 14/02/2024.
//

import SwiftUI

struct aLastOpenedBooks: View {
    @EnvironmentObject var sharedData: SharedData
    @EnvironmentObject var dataController: DataController

    var body: some View {
        VStack(alignment: .leading) {
            Text("Last Opened") .font(.popMid) .padding(.bottom)
            ScrollView(.horizontal) {
                HStack(spacing: 25) {
                    ForEach(dataController.getLastOpenedBooks(count: 5), id: \.self) { book in
                        NavigationLink {
                            BookView(book: book)
                        } label: {
                            allImageTypesView(height: 150, book: book)
                        }
                    }
                }
            }.scrollIndicators(.hidden)
        }.padding()
    }
}

#Preview {
    aLastOpenedBooks()
        .preferredColorScheme(.dark)
        .environmentObject(SharedData())
}
