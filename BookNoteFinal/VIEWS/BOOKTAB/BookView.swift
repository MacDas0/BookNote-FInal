//
//  BookView.swift
//  BookNoteFinal
//
//  Created by Maciej Daszkiewicz on 14/02/2024.
//

import SwiftUI

struct BookView: View {
    @EnvironmentObject var dataController: DataController
    @EnvironmentObject var sharedData: SharedData
    @Environment(\.dismiss) var dismiss
    
    let book: Book

    var body: some View {
        NavigationStack {
            VStack {
                HStack(alignment: .top, spacing: 25) {
                    allImageTypesView(height: 150, book: book)
                    VStack(spacing: 10) {
                        VStack(alignment: .leading, spacing: 2) {
                            Text(book.bookTitle).font(.popMid)
                            Text(book.bookAuthor).font(.popSecondary)
                        }
                        HStack(spacing: 20) {
                            Button {
                                
                            } label: {
                                RoundedRectangle(cornerRadius: 10, style: .continuous).fill(Color.customLightDark) .frame(width: 75, height: 50)
                                .overlay( Text("Read") )
                            }
                                
                            Button {
                                
                            } label: {
                                RoundedRectangle(cornerRadius: 10, style: .continuous).fill(Color.customLightDark) .frame(width: 75, height: 50)
                                .overlay( Text("Write") )
                            }
                        }.padding(.vertical)
                    }
                }

                aNotesList(book: book)
            }.navigationBarTitleDisplayMode(.inline) .globalBackground()
            .toolbar {
                ToolbarItem {
                    Button { } label: { Image("dots_ICON") }
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button { dismiss() } label: { Image("back_ICON") }
                }
            }
        }.navigationBarBackButtonHidden()
            .onAppear {
                dataController.noteFilterTypes = []
                dataController.bookOpened(book: book)
            }
            .onDisappear {
                dataController.noteFilterTypes = []
            }
    }
}
