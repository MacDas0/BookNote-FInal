//
//  MoreView.swift
//  BookNoteFinal
//
//  Created by Maciej Daszkiewicz on 14/02/2024.
//

import SwiftUI

struct MoreView: View {
    @EnvironmentObject var sharedData: SharedData

    var body: some View {
        NavigationStack {
            List {
                Group {
                    Section {
                        RoundedRectangle(cornerRadius: 10, style: .continuous) .fill(Color.customLightDark) .frame(height: 200)
                            .overlay(Text("BookNotes+").font(.popTitle))
                    }
                    Section {
                        NavigationLink("Your account", destination: PlaceholderSettingsView(string: "Your account"))
                        NavigationLink("Preferences", destination: PlaceholderSettingsView(string: "Preferences"))
                        NavigationLink("Notifications", destination: PlaceholderSettingsView(string: "Notifications"))
                        NavigationLink("Restore purchase", destination: PlaceholderSettingsView(string: "Restore purchase"))
                        NavigationLink("Security", destination: PlaceholderSettingsView(string: "Security"))
                        NavigationLink("Report issue", destination: PlaceholderSettingsView(string: "Report issue"))
                        NavigationLink("Suggest idea", destination: PlaceholderSettingsView(string: "Suggest idea"))
                        NavigationLink("Your data", destination: PlaceholderSettingsView(string: "Your data"))
                        NavigationLink("Redeem code", destination: PlaceholderSettingsView(string: "Redeem code"))
                        NavigationLink("Privacy", destination: PlaceholderSettingsView(string: "Privacy"))
                        NavigationLink("Terms and conditions", destination: PlaceholderSettingsView(string: "Terms and conditions"))
                    }
                } .listRowBackground(Color.customLightDark)
            }.font(.popMid) .globalBackground()
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button { sharedData.appState = .main } label: { Image("xmark_ICON") }
                }
            }
        }
    }
}


#Preview {
    MoreView()
        .preferredColorScheme(.dark)
}
