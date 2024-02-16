//
//  googleBooksAPI.swift
//  BookNote
//
//  Created by Maciej Daszkiewicz on 30/12/2023.
//

import SwiftUI
import SwiftyJSON
import SDWebImageSwiftUI
import WebKit

class GoogleBooks: ObservableObject {
    @Published var data = [googleBook]()
    @Published var fail = false
    
    func searchBooksByISBN(isbn: String) {
            let searchTerm = "isbn:\(isbn)"
            searchBooks(searchTerm: searchTerm)
        }

    func searchBooks(searchTerm: String) {
        self.data = [] // Clear the current book data

        // Encode the search term to be URL safe
        let encodedTerm = searchTerm.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let apiKey = "AIzaSyCfPVOOMmw1rUG35CxBJjGHoazm0fZ7f5o"
        let url = "https://www.googleapis.com/books/v1/volumes?q=\(encodedTerm)&key=\(apiKey)&hl=pl"

        guard let urlRequest = URL(string: url) else {
            print("Invalid URL.")
            return
        }

        let session = URLSession(configuration: .default)

        session.dataTask(with: urlRequest) { (data, _, err) in
            // Check for errors
            if let error = err {
                print(error.localizedDescription)
                return
            }

            // Check that data isn't nil
            guard let jsonData = data else {
                print("No data received.")
                return
            }

            do {
                // Parse the JSON data
                let json = try JSON(data: jsonData)
                print(json)
                // Ensure the 'items' array exists
                if let items = json["items"].array {
                    for i in items {
                        let id = UUID()
                        let title = i["volumeInfo"]["title"].stringValue
                        let authors = i["volumeInfo"]["authors"].array ?? []
                        let author = authors.map { $0.stringValue }.joined(separator: ", ")
                        let imurl = i["volumeInfo"]["imageLinks"]["thumbnail"].stringValue
                        let pageCount = i["volumeInfo"]["pageCount"].intValue

                        DispatchQueue.main.async {
                            // Append the book to our published data array
                            self.data.append(googleBook(id: id, title: title, authors: author, imurl: imurl, pageCount: pageCount))
                        }
                    }
                } else {
                    print("No items found or there was an error in the JSON response.")
                    DispatchQueue.main.async {
                        self.fail = true
                    }
                }
            } catch {
                print("JSON parsing error: \(error.localizedDescription)")
            }
            
        }.resume()
    }
}

struct googleBook: Identifiable {
    var id: UUID
    var title: String
    var authors: String
    var imurl: String
    var pageCount: Int
}
