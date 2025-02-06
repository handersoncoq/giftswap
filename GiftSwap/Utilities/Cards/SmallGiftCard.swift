//
//  SmallGiftCard.swift
//  GiftSwap
//
//  Created by Handerson COQ on 2/2/25.
//

import SwiftUI

struct SmallGiftCard: View {
    let gift: Gift
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
                                .stroke(Color("App_Primary"), lineWidth: 1).padding()
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

                SwapStatusView(status: gift.swapStatus)

                if let storeLink = gift.storeLink, let url = URL(string: storeLink) {
                    Link(destination: url) {
                        Text("View in Store")
                            .font(.caption)
                            .foregroundColor(Color.blue)
                    }
                }
            }
            .padding(.horizontal, 8)
            .padding(.bottom, 6)
        }
        .background(Color(.systemBackground))
        .cornerRadius(14)
        .shadow(radius: 3)
        .frame(width: cardSize, height: cardSize)
        .padding(.vertical)
    }
}



struct SmallGiftCard_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            SmallGiftCard(gift: Gift(
                name: "Luxury Watch",
                description: "A sleek and stylish timepiece for any occasion hjhf hjhf hjhj fhjh.",
                imageURLs: [],
                value: 199.99,
                isAvailable: true,
                storeLink: "https://store.com/luxury-watch",
                category: .fashion,
                ownerId: UUID(),
                swapStatus: .available,
                addedAt: Date()
            ))
        }
        .previewLayout(.sizeThatFits)
    }
}
