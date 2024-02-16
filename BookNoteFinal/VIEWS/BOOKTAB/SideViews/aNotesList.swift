//
//  aNotesList.swift
//  BookNoteFinal
//
//  Created by Maciej Daszkiewicz on 14/02/2024.
//

import SwiftUI

struct aNotesList: View {
    @EnvironmentObject var dataController: DataController
    
    let book: Book

    var body: some View {
        VStack {
            TextField("Search", text: $dataController.noteSearchText).padding(8) .background(Color.customLightDark) .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous)) .padding(.horizontal)
            if dataController.getNotesCountForType(book: book) > 1 {
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(getNoteTypes(for: book), id: \.self) { noteType in
                            Button {
                                dataController.selectedNoteType(noteType: noteType)
                            } label: {
                                ZStack {
                                    Text(noteType.capitalizedFirst()).font(.popMini) .padding(.horizontal) .foregroundStyle(dataController.noteFilterTypes.contains(noteType) ? .black : .white) .padding(.vertical, 5) .background(dataController.noteFilterTypes.contains(noteType) ? Color.white : Color.customLightDark).clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                                }
                            }
                        }
                    }
                }.scrollIndicators(.hidden) .padding(.horizontal) .padding(.top, 3)
            }
            List {
                ForEach(dataController.filteredNotes(book: book)) { note in
                    Button {
                        
                    } label: {
                        HStack {
                            Image(dataController.getIconForType(type: note.noteType)).offset(x: -3).frame(width: 25)
                            VStack(alignment: .leading) {
                                Text(note.noteTitle).lineLimit(1)
                                Text(note.noteText).font(.popMini).opacity(0.8).lineLimit(1)
                            }
                        }.padding(.vertical, 5).buttonStyle(PlainButtonStyle())
                    }
                }.listRowBackground(Color.customLightDark)
            }.scrollIndicators(.hidden) .listRowSpacing(5)
        }.padding(.top)
    }
    
    func getNoteTypes(for book: Book) -> [String] {
        var noteTypes: [String] = []
        for note in dataController.getAllNotes(for: book) {
            if !noteTypes.contains(note.noteType) {
                noteTypes.append(note.noteType)
            }
        }
        
        let sortedNoteTypes = noteTypes.sorted(by: {
            // If either is "all", explicitly control its position
            if $0 == "all" {
                return true // Makes "all" always first
            } else if $1 == "all" {
                return false // Keeps "all" first when compared to any other
            } else {
                // Directly compare counts
                let leftCount = dataController.getNotesCountForType(book: book, noteType: $0)
                let rightCount = dataController.getNotesCountForType(book: book, noteType: $1)
                return leftCount > rightCount
            }
        })
        return sortedNoteTypes
    }
}
