//
//  aChangerCoverSheet.swift
//  BookNoteFinal
//
//  Created by Maciej Daszkiewicz on 16/02/2024.
//

import SwiftUI

struct aChangerCoverSheet: View {
    @Binding var changeImage: Bool
    @Binding var showSheet: Bool

    var body: some View {
        HStack {
            Spacer()
            Button {
                changeImage = false
                showSheet = true
            } label: {
                VStack(spacing: 10) {
                    Image("photos_ICON").font(.largeTitle).accessibilityLabel("photos")
                    Text("Search gallery").font(.popMid)
                }
            }
            Spacer()
            Button {
                changeImage = false
            } label: {
                VStack(spacing: 10) {
                    Image("camera_ICON").font(.largeTitle).accessibilityLabel("camera")
                    Text("Take photo").font(.popMid)
                }
            }
            Spacer()
        }
        .presentationDetents([.height(250)])
    }
}

