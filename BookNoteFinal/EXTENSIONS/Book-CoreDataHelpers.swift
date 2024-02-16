//
//  Book-CoreDataHelpers.swift
//  BookNote
//
//  Created by Maciej Daszkiewicz on 05/01/2024.
//

import Foundation

enum BookSource: String, Codable {
    case online
    case kindle
    case scan
    case manual
    case sample
}

extension Book {
    var bookTitle: String {
        get { title ?? ""}
        set { title = newValue }
    }
    
    var bookAuthor: String {
        get { author ?? ""}
        set { author = newValue }
    }
    
    var bookCover: String {
        get { cover ?? ""}
        set { cover = newValue }
    }
    
    var bookSource: BookSource {
        get { BookSource(rawValue: source ?? "") ?? .manual }
        set { source = newValue.rawValue }
    }
    
    var bookDate: Date {
        date ?? .now
    }
    
    var bookLastOpened: Date {
        get { lastOpened ?? Date.now }
        set { lastOpened = newValue }
    }
    
    var bookID: UUID {
        id ?? UUID()
    }
    
    var bookNotes: [Note] {
        let result = notes?.allObjects as? [Note] ?? []
        return result.sorted()
    }
    
    static var example: Book {
        let controller = DataController(inMemory: true)
        let viewContext = controller.container.viewContext
        
        let book = Book(context: viewContext)
        book.title = "Example Book"
        book.author = "Example Author"
        book.cover = "emptyBook"
        book.source = "manual"
        book.id = UUID()
        return book
    }
    
}


extension Book: Comparable {
    public static func <(lhs: Book, rhs: Book) -> Bool {
        let left = lhs.bookDate
        let right = rhs.bookDate
        let left2 = lhs.bookTitle.localizedLowercase
        let right2 = rhs.bookTitle.localizedLowercase
        
        if left == right && left2 == right2 {
            return lhs.bookID.uuidString < rhs.bookID.uuidString
        } else if right == left {
            return left2 < right2
        } else {
            return left > right
        }
    }
}
