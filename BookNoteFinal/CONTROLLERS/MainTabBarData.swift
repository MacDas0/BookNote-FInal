//
//  MainTabBarData.swift
//  BookNote
//
//  Created by Maciej Daszkiewicz on 29/12/2023.
//
import Combine
import Foundation

final class MainTabBarData: ObservableObject {
        
    @Published var sheetClicked = false

    /// This is the index of the item that fires a custom action
    let customActiontemindex: Int

    let objectWillChange = PassthroughSubject<MainTabBarData, Never>()

    var previousItem: Int

    var itemSelected: Int {
        didSet {
            if itemSelected == customActiontemindex {
                previousItem = oldValue
                itemSelected = oldValue
                isCustomItemSelected = true
            }
            objectWillChange.send(self)
        }
    }
        
    func reset() {
        itemSelected = previousItem
        objectWillChange.send(self)
    }
    
    func dismissCustomItemSheet() {
            self.isCustomItemSelected = false
            objectWillChange.send(self)
        }
    
    /// This is true when the user has selected the Item with the custom action
    var isCustomItemSelected: Bool = false

    init(initialIndex: Int = 1, customItemIndex: Int) {
        self.customActiontemindex = customItemIndex
        self.itemSelected = initialIndex
        self.previousItem = initialIndex
    }
}
