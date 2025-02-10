//
//  TopNavMenuItems.swift
//  GiftSwap
//
//  Created by Handerson COQ on 2/10/25.
//

import SwiftUI

struct TopNavMenuItems {
    static let mainItems: [MenuItem] = [
        MenuItem(title: "Profile", systemImage: "person.crop.circle", action: { print("Profile tapped") }),
        MenuItem(title: "Settings", systemImage: "gearshape", action: { print("Settings tapped") }),
        MenuItem(title: "Help", systemImage: "questionmark.circle", action: { print("Help tapped") })
    ]

    static let logoutItem = MenuItem(
        title: "Logout",
        systemImage: "arrow.backward.circle.fill",
        action: { AuthService.shared.logout() },
        role: .destructive
    )
}

struct MenuItem {
    let title: String
    let systemImage: String
    let action: () -> Void
    var role: ButtonRole? = nil
}

