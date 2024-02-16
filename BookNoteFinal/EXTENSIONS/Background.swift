//
//  Background.swift
//  BookNote
//
//  Created by Maciej Daszkiewicz on 29/12/2023.
//

import Foundation
import SwiftUI

struct GlobalBackground: ViewModifier {
    func body(content: Content) -> some View {
        ZStack {
            Color.customDark.edgesIgnoringSafeArea(.all)  // Ensure it covers the entire screen.
            content
        }
    }
}

extension View {
    func globalBackground() -> some View {
        self.modifier(GlobalBackground())
    }
}
