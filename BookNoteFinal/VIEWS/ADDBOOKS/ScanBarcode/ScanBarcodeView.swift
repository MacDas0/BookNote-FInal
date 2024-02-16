//
//  ScanBarcodeView.swift
//  BookNoteFinal
//
//  Created by Maciej Daszkiewicz on 15/02/2024.
//

import PhotosUI
import SwiftUI
import CodeScanner
import SDWebImageSwiftUI
import WebKit

struct ScanBarcodeView: View {
    @EnvironmentObject var dataController: DataController
    @EnvironmentObject var sharedData: SharedData
    @StateObject var imagePicker = ImagePicker()
    @StateObject private var googleBooks = GoogleBooks()
    @FocusState private var focusOnTextField: Bool
    @State private var isPresentingScanner = true
    @State private var isLoading = false
    

    var body: some View {
        NavigationStack {
            if isPresentingScanner {
                aScannerView(isLoading: $isLoading, isPresentingScanner: $isPresentingScanner).environmentObject(googleBooks)
                
            } else if googleBooks.data.isEmpty {
                aProgressView().environmentObject(googleBooks)
                
            } else {
                aScannerConfirmView().environmentObject(googleBooks).environmentObject(imagePicker)
                
            }
        }
        .onAppear { resetAllData(googleBooks: googleBooks) }
    }
    
    func resetAllData(googleBooks: GoogleBooks) {
        isPresentingScanner = true
        isLoading = false
        googleBooks.data = []
    }
}
