//
//  GiftCard.swift
//  GiftSwap
//
//  Created by Handerson COQ on 1/29/25.
//

import SwiftUI

struct GiftCard: View {
    let gift: Gift

    var body: some View {
        VStack(alignment: .leading) {
            ZStack {
                // Use first image in the array
                if let firstImageUrl = gift.imageURLs?.first, !firstImageUrl.isEmpty {
                    AsyncImage(url: URL(string: firstImageUrl)) { image in
                        image.resizable()
                            .scaledToFill()
                            .frame(height: 185)
                            .frame(maxWidth: 450)
                            .clipped()
                    } placeholder: {
                        ProgressView()
                    }
                }

                // Placeholder if no image is available
                if gift.imageURLs?.isEmpty ?? true {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.white.opacity(0.2))
                        .frame(height: 185)
                        .overlay(
                            Image(systemName: "gift.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 50, height: 50)
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
            
            // Gift Details
            VStack(alignment: .leading, spacing: 8) {
                Text(gift.name)
                    .font(.headline)
                    .foregroundColor(.primary)
                    .padding(.top, 4)
                
                Text(gift.description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .lineLimit(1)
                    .truncationMode(.tail)
                

                // Swap Status Badge (Using Reusable View)
                SwapStatusView(status: gift.swapStatus).padding(.bottom)


                // External Store Link (if available)
                if let storeLink = gift.storeLink, let url = URL(string: storeLink) {
                    Link(destination: url) {
                        Text("View in Store")
                            .font(.caption)
                            .foregroundColor(Color.blue)
                            .padding(.bottom)
                            .padding(.top, -6)
                    }
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 6)
            
        }
        .background(Color(.systemBackground))
        .cornerRadius(18)
        .shadow(radius: 10)
        .padding(.horizontal)
        .padding(.bottom, 6)
    }
}


// Preview
struct GiftCard_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            GiftCard(gift: Gift(
                name: "Luxury Watch",
                description: "A sleek and stylish timepiece for any occasion hjhf hjhf hjhj fhjh.",
                imageURLs: ["https://picsum.photos/300/200"],
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
