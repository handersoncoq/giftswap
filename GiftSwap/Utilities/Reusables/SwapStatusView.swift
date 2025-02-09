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
        case .inBasket:
            return "In Swap Basket"
        case .matched:
            return "Reserved for Swap"
        case .swapped:
            return "Already Swapped"
        case .notListed:
            return "Not Listed for Swap"
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
        case .inBasket:
            iconName = "tray.full"
            iconColor = .yellow
        case .matched:
            iconName = "hand.raised.fill"
            iconColor = .blue
        case .swapped:
            iconName = "checkmark.circle.fill"
            iconColor = .gray
        case .notListed:
            iconName = "eye.slash.fill"
            iconColor = .orange
        case .pending:
            iconName = "circle.dotted"
            iconColor = .purple
        }

        return Image(systemName: iconName)
            .foregroundColor(iconColor)
    }
}
