//
//  OccasionView.swift
//  GiftSwap
//
//  Created by Handerson COQ on 2/11/25.
//

import SwiftUI

struct OccasionView: View {
    let occasion: WishlistCategory

    var body: some View {
        HStack {
            OccasionView.occasionIcon(for: occasion)
            Text(OccasionView.occasionText(for: occasion))
                .font(.caption)
                .foregroundColor(.secondary)
        }
    }

    // Occasion text mapping
    static func occasionText(for occasion: WishlistCategory) -> String {
        switch occasion {
        case .birthday: return "Birthday"
        case .anniversary: return "Anniversary"
        case .christmas: return "Christmas"
        case .valentines: return "Valentine’s Day"
        case .wedding: return "Wedding"
        case .graduation: return "Graduation"
        case .babyShower: return "Baby Shower"
        case .housewarming: return "Housewarming"
        case .justBecause: return "Just Because"
        case .personal: return "Personal"
        case .other: return "Other"
        }
    }

    // Occasion icons mapping
    static func occasionIcon(for occasion: WishlistCategory) -> some View {
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
}
