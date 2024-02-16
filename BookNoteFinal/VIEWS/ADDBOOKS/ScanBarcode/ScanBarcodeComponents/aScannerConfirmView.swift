//
//  aScannerConfirmView.swift
//  BookNoteFinal
//
//  Created by Maciej Daszkiewicz on 16/02/2024.
//

import SwiftUI

struct aScannerConfirmView: View {
    @EnvironmentObject var dataController: DataController
    @EnvironmentObject var sharedData: SharedData
    @EnvironmentObject var googleBooks: GoogleBooks
    @EnvironmentObject var imagePicker: ImagePicker
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
        VStack {
            aBookCover(cover: $cover, changeImage: $changeImage, reloadView: $reloadView).environmentObject(imagePicker)

            aBookTextFields(title: $title, author: $author, pageCount: $pageCount, stringPageCount: $stringPageCount)
                
        }.padding(20) .padding(.bottom) .offset(y: -50) .navigationBarBackButtonHidden() .globalBackground()
        .onAppear { loadBookInfo(googleBooks: googleBooks) }
        .photosPicker(isPresented: $showSheet, selection: $imagePicker.imageSelection, matching: .images)
        .sheet(isPresented: $changeImage) { aChangerCoverSheet(changeImage: $changeImage, showSheet: $showSheet) }
        .toolbar { aToolbarScanBarcode(addToLibrary: { Task { self.addToLibrary() } }) }
    }
    
    func loadBookInfo(googleBooks: GoogleBooks) {
        let book = googleBooks.data.first
        title = book?.title ?? "no title found"
        author = book?.authors ?? "no author found"
        id = book?.id ?? UUID()
        pageCount = book?.pageCount ?? 0
        cover = book?.imurl ?? ""
    }
    
    @MainActor func addToLibrary() {
        if let newValue = Int(stringPageCount) {
            pageCount = newValue
        }
        if let uiImage = imagePicker.uiImage {
            FileManager().saveImage(with: id, image: uiImage)
        }
        dataController.createBook(title: title, cover: cover, author: author, source: "manual", id: id, pageCount: pageCount)
        sharedData.appState = .main
    }
}
