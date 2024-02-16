//
//  SearchOnlineView.swift
//  BookNoteFinal
//
//  Created by Maciej Daszkiewicz on 15/02/2024.
//

import SwiftUI
import SwiftyJSON
import SDWebImageSwiftUI
import WebKit

struct SearchOnlineView: View {
    @EnvironmentObject var dataController: DataController
    @EnvironmentObject var sharedData: SharedData
    @StateObject var imagePicker = ImagePicker()
    @StateObject var googleBooks = GoogleBooks()
    @FocusState var KeyboardActivated: Bool
    @State private var searchText = ""
    @State private var confirm = false
    @State private var title = ""
    @State private var author = ""
    @State private var cover = ""
    @State private var pageCount = 0
    @State private var stringPageCount = ""
    @State private var id = UUID()
    @State private var changeImage = false
    @State private var showSheet = false
    @State private var reloadView = false

    var body: some View {
        NavigationStack {
            Group {
                if !confirm {
                    VStack {
                        aSearchBookTextField(searchText: $searchText).environmentObject(googleBooks)
                            .focused($KeyboardActivated)
                        aOnlineBookList(selectBook: selectBook).environmentObject(googleBooks)
                    }.globalBackground() .navigationTitle("Google Books") .navigationBarTitleDisplayMode(.inline) .animation(.default, value: confirm)
                    
                } else {
                    ConfirmBookView(searchText: $searchText, confirm: $confirm, title: $title, author: $author, cover: $cover, pageCount: $pageCount, stringPageCount: $stringPageCount, id: $id, changeImage: $changeImage, showSheet: $showSheet, reloadView: $reloadView)
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) { Button { backButton() } label: { Image("back_ICON").accessibilityLabel("back") }
                }
            }
        }
        .onAppear() {
            KeyboardActivated = true
            confirm = false
            searchText = ""
        }
    }
    
    func selectBook(googleBook: googleBook) {
        id = googleBook.id
        title = googleBook.title
        author = googleBook.authors
        pageCount = googleBook.pageCount
        cover = googleBook.imurl
        confirm = true
    }
    
    func backButton() {
        if confirm == false {
            sharedData.appState = .main
        } else {
            confirm.toggle()
        }
    }
}
