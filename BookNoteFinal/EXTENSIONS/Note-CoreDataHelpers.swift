//
//  Note-CoreDataHelpers.swift
//  BookNote
//
//  Created by Maciej Daszkiewicz on 05/01/2024.
//

import Foundation

extension Note {
    var noteTitle: String {
        get { title ?? ""}
        set { title = newValue }
    }
    
    var noteText: String {
        get { text ?? ""}
        set { text = newValue }
    }
    
    var noteType: String {
        get { type?.lowercased() ?? "basic" }
        set { type = newValue}
        }
    
    var noteDate: Date {
        date ?? .now
    }
    
    var noteID: UUID {
        id ?? UUID()
    }
    
    var noteBook: Book {
//        let nonExistingBook = Book(context: DataController(inMemory: true).container.viewContext)
//        nonExistingBook.title = "This should not exist"
//        nonExistingBook.title = "This should not exist"
        get { book ?? Book(context: DataController(inMemory: true).container.viewContext) }
        set { book = newValue }
//        return book ?? nonExistingBook
    }
    
    static var example: Note {
        let controller = DataController(inMemory: true)
        let viewContext = controller.container.viewContext
        
        let note = Note(context: viewContext)
        note.title = "Example Note"
        note.text = "Example text"
        note.id = UUID()
        return note
    }
}

extension Note: Comparable {
    public static func <(lhs: Note, rhs: Note) -> Bool {
        if lhs.noteType == "summary" && rhs.noteType != "summary" {
            return true
        } else if rhs.noteType == "summary" && lhs.noteType != "summary" {
            return false
        }

        let left = lhs.noteDate
        let right = rhs.noteDate
        let left2 = lhs.noteTitle.localizedLowercase
        let right2 = rhs.noteTitle.localizedLowercase

        if left == right && left2 == right2 {
            return lhs.noteID.uuidString < rhs.noteID.uuidString
        } else if right == left {
            return left2 < right2
        } else {
            return left > right
        }
    }
}
