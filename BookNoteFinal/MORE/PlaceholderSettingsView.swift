//
//  PlaceholderSettingsView.swift
//  BookNote
//
//  Created by Maciej Daszkiewicz on 06/01/2024.
//

import SwiftUI

struct PlaceholderSettingsView: View {
    let string: String

    var body: some View {
        Text(string)
            .font(.popMid)
            .globalBackground()
    }
}

