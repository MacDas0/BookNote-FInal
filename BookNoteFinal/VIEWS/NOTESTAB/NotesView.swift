//
//  NotesView.swift
//  BookNoteFinal
//
//  Created by Maciej Daszkiewicz on 14/02/2024.
//

import SwiftUI

struct NotesView: View {
    @EnvironmentObject var sharedData: SharedData
    let noteTypes = ["All", "Chapters", "Summaries", "Quotes", "Actions", "Journals", "Concepts", "Ideas"]
    let columns = [ GridItem(.adaptive(minimum: 150)) ]

    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10, style: .continuous).fill(Color.customLightDark) .frame(width: 150, height: 100)
                        Image("plus_ICON").font(.system(size: 40))
                    }
                    ForEach(noteTypes, id: \.self) { note in
                        ZStack {
                            RoundedRectangle(cornerRadius: 10, style: .continuous).frame(width: 150, height: 100) .foregroundStyle(Color.customLightDark)
                            Text(note)
                        }
                    }
                }.padding()
            }.globalBackground() .navigationTitle("Notes")
            .toolbar {
                ToolbarItem {
                    Button { sharedData.appState = .more } label: { Image("more_ICON") }
                }
            }
        }
    }
}

#Preview {
    NotesView()
}
