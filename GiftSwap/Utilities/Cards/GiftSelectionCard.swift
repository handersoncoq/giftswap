//
//  GiftSelectionCard.swift
//  GiftSwap
//
//  Created by Handerson COQ on 2/15/25.
//

import SwiftUI

struct GiftSelectionCard<T: GiftProtocol>: View {
    let gift: T
    @Binding var isSelected: Bool
    let onSelect: () -> Void
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
                }
            }
            .cornerRadius(10)

            VStack(alignment: .leading, spacing: 4) {
                Text(gift.name)
                    .font(.headline)
                    .foregroundColor(.primary)
                    .lineLimit(1)

                Text(gift.description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(1)

                HStack {
                    if let swapGift = gift as? SwapGift {
                        SwapStatusView(status: swapGift.swapStatus)
                    }
                    
                    Spacer()

                    //   Selection Button
                    Button(action: {
                        isSelected.toggle()
                        onSelect()
                    }) {
                        Image(systemName: isSelected ? "checkmark.circle.fill" : "circle")
                            .foregroundColor( .appPrimary)
                            .font(.title3)
                            
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

// MARK: - Preview
struct GiftSelectionCard_Previews: PreviewProvider {
    static var previews: some View {
        @State var isSelected = true
        return GiftSelectionCard(
            gift: SwapGift(
                name: "Luxury Watch",
                description: "A premium stainless steel watch",
                imageURLs: ["https://picsum.photos/200"],
                value: 250.00,
                isAvailable: true,
                storeLink: nil,
                category: .fashion,
                ownerId: UUID(),
                swapStatus: .available,
                addedAt: Date()
            ),
            isSelected: $isSelected,
            onSelect: {print("pressed")}
        )
        .previewDisplayName("Gift Selection Card")
    }
}
