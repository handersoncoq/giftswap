//
//  WishlistCard.swift
//  GiftSwap
//
//  Created by Handerson COQ on 2/11/25.
//

import SwiftUI

struct WishlistCard: View {
    let wishlist: Wishlist
    let onDelete: () -> Void

    private let cardHeight: CGFloat = 100

    var body: some View {
        HStack(spacing: 12) {
            // Occasion Icon
            OccasionIcons(for: wishlist.category)
                .font(.largeTitle)
                .frame(width: 50, height: 50)
                .background(Color("App_Primary").opacity(0.1))
                .clipShape(Circle())

            VStack(alignment: .leading, spacing: 5) {
                Text(wishlist.name)
                    .font(.headline)
                    .foregroundColor(.primary)

                if let description = wishlist.description, !description.isEmpty {
                    Text(description)
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .lineLimit(1)
                        .truncationMode(.tail)
                }

                Text(wishlist.category.rawValue.capitalized)
                    .font(.footnote)
                    .foregroundColor(.gray)
            }

            Spacer()

            // Delete Button
            Button(action: onDelete) {
                Image(systemName: "trash")
                    .foregroundColor(.red)
                    .frame(width: 30, height: 30)
                    .background(Color.white.clipShape(Circle()))
            }
        }
        .padding()
        .frame(height: cardHeight)
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(radius: 10)
    }
}
