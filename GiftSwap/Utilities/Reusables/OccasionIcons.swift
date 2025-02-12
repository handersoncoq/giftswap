//
//  OccasionIcons.swift
//  GiftSwap
//
//  Created by Handerson COQ on 2/11/25.
//

import SwiftUI

// Occasion icons mapping
func OccasionIcons(for occasion: WishlistCategory) -> some View {
    let iconName: String
    let iconColor: Color

    switch occasion {
    case .birthday:
        iconName = "gift.fill"
        iconColor = Color("App_Primary")
    case .anniversary:
        iconName = "heart.fill"
        iconColor = .red
    case .christmas:
        iconName = "tree.fill"
        iconColor = .green
    case .valentines:
        iconName = "heart.circle.fill"
        iconColor = .pink
    case .wedding:
        iconName = "diamond.fill"
        iconColor = .purple
    case .graduation:
        iconName = "graduationcap.fill"
        iconColor = .yellow
    case .babyShower:
        iconName = "figure.child"
        iconColor = .orange
    case .housewarming:
        iconName = "house.fill"
        iconColor = .brown
    case .justBecause:
        iconName = "hand.raised.fill"
        iconColor = .cyan
    case .personal:
        iconName = "person.fill"
        iconColor = .blue
    case .other:
        iconName = "ellipsis.circle.fill"
        iconColor = .gray
    }

    return Image(systemName: iconName)
        .foregroundColor(iconColor)
}
