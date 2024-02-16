//
//  aRecommendedBooks.swift
//  BookNoteFinal
//
//  Created by Maciej Daszkiewicz on 14/02/2024.
//

import SwiftUI

struct aRecommendedBooks: View {
    @EnvironmentObject var sharedData: SharedData

    var body: some View {
        VStack(alignment: .leading) {
            Text("Recommended") .font(.popMid) .padding(.bottom)
            ScrollView(.horizontal) {
                HStack(spacing: 25) {
                    ForEach(sharedData.sampleBooks.shuffled().prefix(5), id: \.self) { book in
                        Image(book).resizable() .scaledToFill() .frame(width: 150*6/9, height: 150) .clipShape(RoundedRectangle(cornerRadius: 5, style: .continuous))
                    }
                }
            }.scrollIndicators(.hidden)
        }.padding()
    }
}

#Preview {
    aRecommendedBooks()
        .preferredColorScheme(.dark)
        .environmentObject(SharedData())
}
