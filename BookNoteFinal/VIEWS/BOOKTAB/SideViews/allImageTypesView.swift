//
//  allImageTypesView.swift
//  BookNote
//
//  Created by Maciej Daszkiewicz on 02/01/2024.
//

import SwiftUI
import WebKit
import SDWebImageSwiftUI

struct allImageTypesView: View {
    var coverImageSpace: Namespace.ID?
    @Namespace var placeholder
    let height: CGFloat
    let book: Book

    var body: some View {
        Group {
            if book.bookSource != .sample {
                if let uiImage = FileManager().retrieveImage(with: book.bookID) {
                    Image(uiImage: uiImage).resizable()

                } else if !book.bookCover.isEmpty {
                    WebImage(url: URL(string: book.bookCover)!).resizable()

                } else {
                    Image("emptyBook").resizable()

                }
            } else {
                Image(book.bookCover).resizable()

            }
        }.scaledToFill() .matchedGeometryEffect(id: book.bookID, in: coverImageSpace ?? placeholder) .frame(width: height*6/9, height: height) .clipShape(RoundedRectangle(cornerRadius: 5, style: .continuous))
    }
    
    init(height: CGFloat, book: Book, coverImageSpace: Namespace.ID? = nil) {
        self.height = height
        self.book = book
        self.coverImageSpace = coverImageSpace
    }
}
