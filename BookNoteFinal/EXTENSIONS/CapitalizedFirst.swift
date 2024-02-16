//
//  CapitalizedFirst.swift
//  BookNote
//
//  Created by Maciej Daszkiewicz on 01/01/2024.
//


extension String {
    func capitalizedFirst() -> String {
        return prefix(1).capitalized + dropFirst()
    }
}
