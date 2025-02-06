//
//  SettingsView.swift
//  GiftSwap
//
//  Created by Handerson COQ on 1/27/25.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("notificationsEnabled") private var notificationsEnabled = false
    @AppStorage("defaultBudget") private var defaultBudget = 50.0

    var body: some View {
        Form {
            Section(header: Text("Preferences")) {
                Toggle("Enable Notifications", isOn: $notificationsEnabled)
                Stepper("Default Budget: $\(defaultBudget, specifier: "%.2f")", value: $defaultBudget, in: 10...500, step: 10)
            }
        }
        .navigationTitle("Settings")
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
