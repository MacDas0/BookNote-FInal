//
//  aScannerView.swift
//  BookNoteFinal
//
//  Created by Maciej Daszkiewicz on 16/02/2024.
//

import SwiftUI
import CodeScanner

struct aScannerView: View {
    @EnvironmentObject var googleBooks: GoogleBooks
    @EnvironmentObject var sharedData: SharedData
    @Binding var isLoading: Bool
    @Binding var isPresentingScanner: Bool

    var body: some View {
        CodeScannerView(
            codeTypes: [.ean13],
            completion: { result in
                if case let .success(code) = result {
                    isLoading = true
                    googleBooks.searchBooksByISBN(isbn: code.string)
                    isPresentingScanner = false
                }
            }
        )
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button { sharedData.appState = .main } label: { Image("back_ICON").accessibilityLabel("back") }
            }
            ToolbarItem(placement: .principal) {
                Text("Scan book barcode")
            }
        }
    }
}
