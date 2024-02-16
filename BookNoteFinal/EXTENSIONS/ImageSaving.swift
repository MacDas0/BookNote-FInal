//
//  ImageSaving.swift
//  BookNote
//
//  Created by Maciej Daszkiewicz on 09/01/2024.
//

import UIKit

extension FileManager {
    func retrieveImage(with id: UUID) -> UIImage? {
        let url = URL.documentsDirectory.appendingPathComponent("\(id).jpg")
        do {
            let imageData = try Data(contentsOf: url)
            return UIImage(data: imageData)
        } catch {
            return nil
        }
    }

    func saveImage(with id: UUID, image: UIImage) {
        if let data = image.jpegData(compressionQuality: 0.7) {
            do {
                let url = URL.documentsDirectory.appendingPathComponent("\(id).jpg")
                try data.write(to: url)
            } catch {
                print(error.localizedDescription)
            }
        } else {
            print("Could not save image")
        }
    }

    func deleteImage(with id: UUID) {
        let url = URL.documentsDirectory.appendingPathComponent("\(id).jpg")
        if fileExists(atPath: url.path) {
            do {
                try removeItem(at: url)
            } catch {
                print(error.localizedDescription)
            }
        } else {
            print("Image does not exist")
        }
    }

}
