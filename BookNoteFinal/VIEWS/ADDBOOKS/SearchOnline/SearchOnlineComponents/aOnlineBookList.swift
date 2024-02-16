//
//  aOnlineBookList.swift
//  BookNoteFinal
//
//  Created by Maciej Daszkiewicz on 16/02/2024.
//

import SwiftUI
import SDWebImageSwiftUI

extension SearchOnlineView {
    struct aOnlineBookList: View {
        @EnvironmentObject var googleBooks: GoogleBooks
        let selectBook: (googleBook) -> Void
        
        var body: some View {
            List(googleBooks.data) { googleBook in
                Button {
                    selectBook(googleBook)
                } label: {
                    HStack {
                        Group {
                            if googleBook.imurl != "" {
                                WebImage(url: URL(string: googleBook.imurl)!).resizable().frame(width: 120, height: 170) .clipShape(RoundedRectangle(cornerRadius: 10))
                            } else {
                                Image("emptyBook").resizable() .frame(width: 120, height: 170) .clipShape(RoundedRectangle(cornerRadius: 10))
                            }
                        }
                        
                        VStack(alignment: .leading, spacing: 10) {
                            Text(googleBook.title).font(.popTitle)
                            Text(googleBook.authors).font(.popMid)
                            Text("\(String(googleBook.pageCount)) pages").font(.popMini)
                        }.padding()
                    }
                }
            }
        }
    }
}
