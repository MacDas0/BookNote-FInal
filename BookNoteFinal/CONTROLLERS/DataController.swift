//
//  DataController.swift
//  BookNote
//
//  Created by Maciej Daszkiewicz on 05/01/2024.
//

import CoreData
import UIKit
import SwiftUI

class DataController: ObservableObject {
    let container: NSPersistentCloudKitContainer
    
    @Published var notesTypes = ["basic", "chapter", "quote", "action", "idea", "journal", "concept"]
    
    @Published var searchText = ""
    @Published var noteSearchText = ""
    @Published var noteFilterTypes = Set<String>()
    @Published var showSearchText = false
    
    var filteredNotesCount: Int {
        filteredNotes().count
    }
    
    private var saveTask: Task<Void, Error>?
    
    static var preview: DataController = {
        let dataController = DataController(inMemory: true)
        dataController.createSampleData()
        return dataController
    }()
    
    init(inMemory: Bool = false) {
        container = NSPersistentCloudKitContainer(name: "Main")
        
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(filePath: "/dev/null")
        }
        
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        
        container.persistentStoreDescriptions.first?.setOption(true as NSNumber, forKey: NSPersistentStoreRemoteChangeNotificationPostOptionKey)
        NotificationCenter.default.addObserver(forName: .NSPersistentStoreRemoteChange, object: container.persistentStoreCoordinator, queue: .main, using: remoteStoreChanged)
        
        container.loadPersistentStores { sortDescription, error in
            if let error {
                fatalError("Failed error loading store: \(error.localizedDescription)")
            }
        }
    }
    
    func remoteStoreChanged(_notification: Notification) {
        objectWillChange.send()
    }
    
    func filteredBooks() -> [Book] {
        let trimmedFilterText = searchText.trimmingCharacters(in: .whitespaces)
        let request = Book.fetchRequest()
        if !trimmedFilterText.isEmpty {
            request.predicate = NSPredicate(format: "title CONTAINS[c] %@", trimmedFilterText)
        }
        let allBooks = (try? container.viewContext.fetch(request)) ?? []
        return allBooks.sorted()
    }
    
    func getAllNotes(for book: Book? = nil) -> [Note] {
        let request = Note.fetchRequest()
        var predicates = [NSPredicate]()
        
        if book != nil {
            let bookPredicate = NSPredicate(format: "book.title CONTAINS %@", book!.bookTitle)
            predicates.append(bookPredicate)
        }
        
        request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
        let allNotes = (try? container.viewContext.fetch(request)) ?? []
        return allNotes.sorted()
    }
    
    func getNotesCountForType(book: Book, noteType: String = "") -> Int {
        let request = Note.fetchRequest()
        var predicates = [NSPredicate]()
        
        let bookPredicate = NSPredicate(format: "book.title CONTAINS %@", book.bookTitle)
        predicates.append(bookPredicate)
        
        if (noteType != "all" && noteType != "") {
            let noteTypePredicate = NSPredicate(format: "type CONTAINS[c] %@", noteType)
            predicates.append(noteTypePredicate)
        }
        
        request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
        let allNotes = (try? container.viewContext.fetch(request)) ?? []
        return allNotes.count
    }
    
    func filteredNotes(book: Book? = nil, noteType: String = "") -> [Note] {
//        let filter =  selectedFilter ?? .all
        var predicates = [NSPredicate]()
        let request = Note.fetchRequest()
        let trimmedFilterText = noteSearchText.trimmingCharacters(in: .whitespaces)
        if !trimmedFilterText.isEmpty {
            let titlePredicate = NSPredicate(format: "title CONTAINS[c] %@", trimmedFilterText)
            let textPredicate = NSPredicate(format: "text CONTAINS[c] %@", trimmedFilterText)
            let combinedPredicate = NSCompoundPredicate(orPredicateWithSubpredicates: [titlePredicate, textPredicate])
            predicates.append(combinedPredicate)
        }
        
        if !noteFilterTypes.isEmpty {
            var typePredicates = [NSPredicate]()
            for type in noteFilterTypes {
                let typePredicate = NSCompoundPredicate(format: "type CONTAINS[c] %@", type)
                typePredicates.append(typePredicate)
            }
            let combinedTypePredicates = NSCompoundPredicate(orPredicateWithSubpredicates: typePredicates)
            predicates.append(combinedTypePredicates)
        }
        
        if book != nil {
            let bookPredicate = NSPredicate(format: "book.title CONTAINS %@", book!.bookTitle)
            predicates.append(bookPredicate)
        }
        
        if (noteType != "all" && noteType != "") {
            let noteTypePredicate = NSPredicate(format: "type CONTAINS[c] %@", noteType)
            predicates.append(noteTypePredicate)
        }
        
        request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
        let allNotes = (try? container.viewContext.fetch(request)) ?? []
        return allNotes.sorted()
    }
    
    func createBook(title: String = "", cover: String = "emptyBook", author: String = "", source: String = "", id: UUID = UUID(), pageCount: Int = 0, kindle: Bool = false, read: Bool = false) {
        let newBook = Book(context: container.viewContext)
        let dateNow = Date.now
        newBook.title = title
        newBook.cover = cover
        newBook.author = author
        newBook.id = id
        newBook.source = source
        newBook.pageCount = Int16(pageCount)
        newBook.kindle = kindle
        newBook.read = read
        newBook.date = dateNow
        newBook.lastOpened = dateNow
        save()
    }
    
    func createNote(book: Book, title: String = "", text: String = "", noteType: String = "basic", id: UUID = UUID()) {
        let newNote = Note(context: container.viewContext)
        newNote.title = title
        newNote.id = id
        newNote.text = text
        newNote.noteType = noteType
        newNote.date = Date.now
        book.addToNotes(newNote)
        save()
    }
    
    /** Creates and returns a note*/
    func createAndFetchNote(book: Book, title: String = "", text: String = "", noteType: String = "basic", id: UUID = UUID()) -> Note {
        let newNote = Note(context: container.viewContext)
        newNote.title = title
        newNote.id = id
        newNote.text = text
        newNote.noteType = noteType
        newNote.date = Date.now
        book.addToNotes(newNote)
        save()
        return newNote
    }
    

    func editNote(note: Note, title: String = "", text: String = "") {
        if !title.isEmpty {
            note.title = title
        }
        if !text.isEmpty {
            note.text = text
        }
        save()
    }
    
    func queueEditNote(note: Note, title: String, text: String) {
        saveTask?.cancel()
        
        saveTask = Task {
            try await Task.sleep(for: .seconds(1))
                editNote(note: note, title: title, text: text)
        }
    }
    
    func bookCompleted(book: Book) {
        book.read.toggle()
        if book.read == true {
            let summaryNote = Note(context: container.viewContext)
            summaryNote.title = "Final summary"
            summaryNote.text = ""
            summaryNote.type = "summary"
            summaryNote.id = UUID()
            summaryNote.date = Date.now
            book.addToNotes(summaryNote)
        } else {
            if let summaryNote = book.bookNotes.filter({$0.noteType == "summary"}).first {
                delete(summaryNote)
            }
        }
        save()
    }
    
    func getBook(from id: UUID) -> Book {
        let request = Book.fetchRequest()
        let allBooks = (try? container.viewContext.fetch(request)) ?? []
        return allBooks.first(where: { $0.bookID == id }) ?? allBooks.first ?? Book()
    }
    
    func getLastOpenedBooks(count: Int) -> [Book] {
        var books = [Book]()
        let request = Book.fetchRequest()
        let allBooks = (try? container.viewContext.fetch(request)) ?? []
        for book in allBooks {
            if book.bookDate != book.bookLastOpened {
                books.append(book)
            }
        }
        let sortedBooks = books.sorted(by: { $0.bookLastOpened > $1.bookLastOpened })
        return Array(sortedBooks.prefix(count))
    }
    
    func bookOpened(book: Book) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            book.bookLastOpened = .now
            self.save()
        }
    }
    
    func save() {
        if container.viewContext.hasChanges {
            try? container.viewContext.save()
        }
    }
    
    func delete(_ object: NSManagedObject) {
        objectWillChange.send()
        container.viewContext.delete(object)
        save()
    }
    
    private func delete(_ fetchRequest: NSFetchRequest<NSFetchRequestResult>) {
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        batchDeleteRequest.resultType = .resultTypeObjectIDs
        
        if let delete = try? container.viewContext.execute(batchDeleteRequest) as? NSBatchDeleteResult {
            let changes = [NSDeletedObjectsKey: delete.result as? [NSManagedObjectID] ?? []]
            NSManagedObjectContext.mergeChanges(fromRemoteContextSave: changes, into: [container.viewContext])
        }
    }
    
    func deleteAll() {
        let request1: NSFetchRequest<NSFetchRequestResult> = Book.fetchRequest()
        delete(request1)
        let request2: NSFetchRequest<NSFetchRequestResult> = Note.fetchRequest()
        delete(request2)
        
        save()
    }
    
    func createSampleData() {
        let viewContext = container.viewContext
        
        for i in 1...8 {
            let book = Book(context: viewContext)
            let dateNow = Date.now
            book.source = "sample"
            book.id = UUID()
            book.notes = []
            book.pageCount = 0
            book.kindle = false
            book.read = false
            book.date = dateNow
            book.bookLastOpened = dateNow
            if i == 1 {
                book.title = "Economics For Dummies"
                book.cover = "economicsfordummies"
                book.author = "Sean Masaki Flynn"
            } else if i == 2 {
                book.title = "The 4-Hour Workweek"
                book.cover = "thefourhourworkweek"
                book.author = "Tim Ferriss"
            } else if i == 3 {
                book.title = "Meditations"
                book.cover = "meditations"
                book.author = "Marcus Aurelius"
            } else if i == 4 {
                book.title = "Four Thousand Weeks"
                book.cover = "fourthousandweeks"
                book.author = "Oliver Burkeman"
            } else if i == 5 {
                book.title = "Deep Work"
                book.cover = "deepwork"
                book.author = "Cal Newport"
            } else if i == 6 {
                book.title = "Sapiens"
                book.cover = "sapiens"
                book.author = "Yuval Noah Harari"
            } else if i == 7 {
                book.title = "On Having No Head"
                book.cover = "onhavingnohead"
                book.author = "Douglas E. Harding"
            } else if i == 8 {
                book.title = "The Magic of Thinking Big"
                book.cover = "themagicofthinkingbig"
                book.author = "David J. Schwartz"
            }
            for j in 1...5 {
                let note = Note(context: viewContext)
                note.id = UUID()
                note.title = "Note \(j)"
                note.text = "I love reading books"
                note.type = "basic"
                note.date = Date.now
                book.addToNotes(note)
            }
        }
        loadSampleNotes()
        try? viewContext.save()
    }
    
    func fetchOrCreateBook(withTitle title: String) -> Book {
           let fetchRequest: NSFetchRequest<Book> = Book.fetchRequest()
           fetchRequest.predicate = NSPredicate(format: "title == %@", title)

           do {
               let results = try container.viewContext.fetch(fetchRequest)
               if let existingBook = results.first {
                   // Return the existing book
                   return existingBook
               }
           } catch {
               print("Error fetching book: \(error)")
           }

           // If no existing book is found, create a new one
           let newBook = Book(context: container.viewContext)
           newBook.title = title
           newBook.id = UUID()
           newBook.date = Date.now
           // Set other default properties of Book if needed
           save()

           return newBook
       }
    
    func loadSampleNotes() {
        guard let url = Bundle.main.url(forResource: "SampleNotes", withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            print("Error loading JSON")
            return
        }

        let decoder = JSONDecoder()
        guard let loadedNotes = try? decoder.decode([BookNotesData].self, from: data) else {
            print("Error decoding JSON")
            return
        }

        for bookNote in loadedNotes {
            let book = fetchOrCreateBook(withTitle: bookNote.bookTitle)
            for noteData in bookNote.notes {
                createNote(book: book, title: noteData.title, text: noteData.text, noteType: notesTypes.randomElement() ?? "basicNote")
            }
        }
    }
    
    func deleteEmptyNotes() {
        for note in filteredNotes() {
            if note.noteTitle.isEmpty && note.noteText.isEmpty {
                delete(note)
            }
        }
    }
    
    func getIconForType(type: String) -> String {
        switch type {
        case "all":
            return "basicNote_ICON"
        case "basic":
            return "basicNote_ICON"
        case "chapter":
            return "chapter_ICON"
        case "action":
            return "action_ICON"
        case "idea":
            return "idea_ICON"
        case "journal":
            return "journal_ICON"
        case "summary":
            return "summary_ICON"
        case "concept":
            return "concept_ICON"
        default:
            return "basicNote_ICON"
        }
    }
    
    func selectedNoteType(noteType: String) {
        if noteFilterTypes.contains(noteType) {
            noteFilterTypes.remove(noteType)
        } else {
            noteFilterTypes.insert(noteType)
        }
    }
}

struct BookNotesData: Codable {
    var bookTitle: String
    var notes: [NoteData]
}

struct NoteData: Codable {
    var title: String
    var text: String
}

