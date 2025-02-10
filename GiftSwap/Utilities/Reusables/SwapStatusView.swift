//
//  SwapStatusView.swift
//  GiftSwap
//
//  Created by Handerson COQ on 2/1/25.
//

import SwiftUI

struct SwapStatusView: View {
    let status: SwapStatus

    var body: some View {
        HStack {
            SwapStatusView.swapStatusIcon(for: status)
            Text(SwapStatusView.statusText(for: status))
                .font(.caption)
                .foregroundColor(.secondary)
        }
    }

    // Swap status text
    static func statusText(for status: SwapStatus) -> String {
        switch status {
        case .available:
            return "Swappable"
        case .swapped:
            return "Swapped"
        case .pending:
            return "Swap Pendding"
        }
    }

    // Swap status icons
    static func swapStatusIcon(for status: SwapStatus) -> some View {
        let iconName: String
        let iconColor: Color

        switch status {
        case .available:
            iconName = "arrow.2.circlepath"
            iconColor = Color("App_Primary")
        case .pending:
            iconName = "circle.dotted"
            iconColor = .orange
        case .swapped:
            iconName = "checkmark.circle.fill"
            iconColor = .green
        }

        return Image(systemName: iconName)
            .foregroundColor(iconColor)
    }
}
