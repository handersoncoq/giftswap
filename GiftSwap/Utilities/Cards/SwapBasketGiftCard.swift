//
//  SwapBasketGiftCard.swift
//  GiftSwap
//
//  Created by Handerson COQ on 2/8/25.
//

import SwiftUI

struct SwapBasketGiftCard: View {
    let gift: Gift
    let onRemove: () -> Void
    private let cardSize: CGFloat = 170

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            ZStack {
                if let firstImageUrl = gift.imageURLs?.first, !firstImageUrl.isEmpty {
                    AsyncImage(url: URL(string: firstImageUrl)) { image in
                        image.resizable()
                            .scaledToFill()
                            .frame(width: cardSize, height: cardSize * 0.6)
                            .clipped()
                    } placeholder: {
                        ProgressView()
                    }
                } else {
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.white.opacity(0.2))
                        .frame(width: cardSize, height: cardSize * 0.6)
                        .overlay(
                            Image(systemName: "gift.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 40, height: 40)
                                .foregroundColor(Color("App_Primary"))
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color("App_Primary"), lineWidth: 1)
                                .padding()
                                .padding(.bottom, -12)
                        )
                }
            }
            .cornerRadius(10)

            VStack(alignment: .leading, spacing: 4) {
                Text(gift.name)
                    .font(.headline)
                    .foregroundColor(.primary)
                    .lineLimit(1)
                    .truncationMode(.tail)

                Text(gift.description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(1)
                    .truncationMode(.tail)

                HStack {
                    SwapStatusView(status: gift.swapStatus)
                        .padding(.vertical, 10)

                    Spacer()

                    // Remove button (only if status is not "pending")
                    if gift.swapStatus != .pending {
                        Button(action: onRemove) {
                            Image(systemName: "trash")
                                .resizable()
                                .frame(width: 24, height: 24)
                                .foregroundColor(.red)
                                .background(Color.white.clipShape(Circle()))
                        }
                        .padding(.trailing, 4)
                    }
                }
            }
            .padding(.horizontal, 8)
            .padding(.bottom, 8)
        }
        .background(Color(.systemBackground))
        .cornerRadius(14)
        .shadow(radius: 3)
        .frame(width: cardSize, height: cardSize)
        .padding(.vertical)
    }
}


struct SwapBasketGiftCard_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            SwapBasketGiftCard(gift: Gift(
                name: "Luxury Watch",
                description: "A sleek and stylish timepiece for any occasion hjhf hjhf hjhj fhjh.",
                imageURLs: ["https://picsum.photos/300/200", "https://picsum.photos/300/200"],
                value: 199.99,
                isAvailable: true,
                storeLink: "https://store.com/luxury-watch",
                category: .fashion,
                ownerId: UUID(),
                swapStatus: .available,
                addedAt: Date()
            ), onRemove: {print("Removed")})
        }
        .previewLayout(.sizeThatFits)
    }
}
