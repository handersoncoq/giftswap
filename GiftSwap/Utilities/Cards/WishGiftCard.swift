//
//  WishGiftCard.swift
//  GiftSwap
//
//  Created by Handerson COQ on 2/10/25.
//

import SwiftUI

struct WishGiftCard: View {
    let gift: WishGift
    let onRemove: () -> Void
    private let cardSize: CGFloat = 170

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            ZStack {
                if let firstImageUrl = gift.images.first, !firstImageUrl.isEmpty {
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
                    if let price = gift.price, let currency = gift.currency {
                        Text("\(currency) \(String(format: "%.2f", price))")
                            .font(.caption)
                            .foregroundColor(Color.blue).padding(.vertical, 10)
                    } else {
                        Text("Price Unavailable")
                            .font(.subheadline)
                            .foregroundColor(.gray).padding(.vertical, 10)
                    }

                    Spacer()

                    // Remove button
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

struct WishGiftCard_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            WishGiftCard(gift: WishGift(
                id: UUID(), name: "Gift 1", description: "A beautiful gift", category: .beauty, images: ["https://picsum.photos/300/200", "https://picsum.photos/300/200"], storeLink: "String", price: 25, currency: "USD", brand: "nike", addedDate: Date(),
                wishListId: UUID()
            ), onRemove: {print("Removed")})
        }
        .previewLayout(.sizeThatFits)
    }
}
