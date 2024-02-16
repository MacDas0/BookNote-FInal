//
//  AddManuallyView.swift
//  BookNoteFinal
//
//  Created by Maciej Daszkiewicz on 15/02/2024.
//

import PhotosUI
import SwiftUI
import SDWebImageSwiftUI
import WebKit

struct AddManuallyView: View {
    @EnvironmentObject var dataController: DataController
    @EnvironmentObject var sharedData: SharedData
    @StateObject var imagePicker = ImagePicker()
    @FocusState private var focusOnTextField: Bool
    
    @State private var books = [Book]()
    @State private var title: String = ""
    @State private var author: String = ""
    @State private var cover: String = ""
    @State private var pageCount: Int = 0
    @State private var stringPageCount: String = ""
    @State private var id: UUID = UUID()
    @State private var changeImage = false
    @State private var showSheet = false
    @State private var reloadView = false

    var body: some View {
        NavigationStack {
            VStack {
                aBookCover(cover: $cover, changeImage: $changeImage, reloadView: $reloadView)
                
                aBookTextFields(title: $title, author: $author, pageCount: $pageCount, stringPageCount: $stringPageCount)
                    
            }.padding(20) .padding(.bottom) .offset(y: -50) .navigationBarBackButtonHidden() .globalBackground()
            .photosPicker(isPresented: $showSheet, selection: $imagePicker.imageSelection, matching: .images)
            .sheet(isPresented: $changeImage) { aChangerCoverSheet(changeImage: $changeImage, showSheet: $showSheet) }
            .toolbar { aToolbarManualAdd(addToLibrary: { Task { self.addToLibrary() } }) }

        }
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
