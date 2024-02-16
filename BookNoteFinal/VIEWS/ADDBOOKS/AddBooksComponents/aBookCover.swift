//
//  aBookCover.swift
//  BookNoteFinal
//
//  Created by Maciej Daszkiewicz on 16/02/2024.
//

import SwiftUI
import SDWebImageSwiftUI

struct aBookCover: View {
    @EnvironmentObject var imagePicker: ImagePicker
    @Binding var cover: String
    @Binding var changeImage: Bool
    @Binding var reloadView: Bool
    var body: some View {
        Group {
            if imagePicker.image != nil {
                imagePicker.image!.resizable()
            } else if cover != "" {
                WebImage(url: URL(string: cover)!).resizable()
            } else {
                Image("addBook").resizable()
            }
        } .scaledToFill() .frame(width: 300*6/9, height: 300) .clipShape(RoundedRectangle(cornerRadius: 10)) .padding()
            .onTapGesture { changeImage = true }
            .contextMenu {
                Button(role: .destructive) {
                    deselectImage()
                } label: {
                    Text("Deselect image")
                }
            }
    }
    
    
    @MainActor func deselectImage() {
        imagePicker.imageSelection = nil
        imagePicker.image = nil
        imagePicker.uiImage = nil
        reloadView.toggle()
    }
}

