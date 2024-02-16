//
//  ConfirmView.swift
//  BookNoteFinal
//
//  Created by Maciej Daszkiewicz on 15/02/2024.
//

import PhotosUI
import SwiftUI
import SwiftyJSON
import SDWebImageSwiftUI
import WebKit

struct ConfirmBookView: View {
    @EnvironmentObject var dataController: DataController
    @EnvironmentObject var sharedData: SharedData
    @StateObject var imagePicker = ImagePicker()
    @Binding var searchText: String
    @Binding var confirm: Bool
    @Binding var title: String
    @Binding var author: String
    @Binding var cover: String
    @Binding var pageCount: Int
    @Binding var stringPageCount: String
    @Binding var id: UUID
    @Binding var changeImage: Bool
    @Binding var showSheet: Bool
    @Binding var reloadView: Bool

    var body: some View {
        VStack {
            VStack {
                aBookCover(cover: $cover, changeImage: $changeImage, reloadView: $reloadView).environmentObject(imagePicker)

                aBookTextFields(title: $title, author: $author, pageCount: $pageCount, stringPageCount: $stringPageCount)
                
            }.padding(20).padding(.bottom)
        }.offset(y: -50) .navigationBarBackButtonHidden() .globalBackground()
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button { addToLibrary() } label: { Image("tick_ICON") }
            }
        }
        .photosPicker(isPresented: $showSheet, selection: $imagePicker.imageSelection, matching: .images)
        .sheet(isPresented: $changeImage) {
            aChangerCoverSheet(changeImage: $changeImage, showSheet: $showSheet)
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
    
    func resetPageCount() {
        if pageCount == 0 {
            stringPageCount = "0"
        }
    }
}
