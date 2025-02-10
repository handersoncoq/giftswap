//
//  MenuView.swift
//  GiftSwap
//
//  Created by Handerson COQ on 2/10/25.
//

import SwiftUI

struct MenuView: View {
    @ObservedObject var authService = AuthService.shared

    var body: some View {
        Menu {
            ForEach(TopNavMenuItems.mainItems, id: \.title) { item in
                Button(action: item.action) {
                    Label(item.title, systemImage: item.systemImage)
                }
            }

            Divider()

            if authService.isLoggingOut {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.vertical, 5)
            } else {
                Button(role: .destructive, action: { authService.logout() }) {
                    Label("Logout", systemImage: "arrow.backward.circle.fill")
                }
            }
        } label: {
            Image(systemName: "line.3.horizontal.decrease")
                .foregroundColor(.primary)
        }
        .menuStyle(BorderlessButtonMenuStyle())
    }
}






