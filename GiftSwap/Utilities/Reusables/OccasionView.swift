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
            OccasionIcons(for: occasion)
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

}
