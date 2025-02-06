//
//  GiftDetailView.swift
//  GiftSwap
//
//  Created by Handerson COQ on 1/27/25.
//

import SwiftUI

struct GiftDetailView: View {
    let gift: Gift
    @State private var currentIndex: Int = 0

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 14) {
                if let images = gift.imageURLs, !images.isEmpty {
                    ZStack {
                        TabView(selection: $currentIndex) {
                            ForEach(images.indices, id: \.self) { index in
                                AsyncImage(url: URL(string: images[index])) { phase in
                                    switch phase {
                                    case .empty:
                                        ProgressView()
                                            .frame(height: 350)

                                    case .success(let image):
                                        image
                                            .resizable()
                                            .scaledToFit()
                                            .frame(maxWidth: 450)
                                            .cornerRadius(16)

                                    case .failure:
                                        PlaceholderView()
                                            .frame(height: 350)

                                    @unknown default:
                                        EmptyView()
                                    }
                                }
                                .tag(index)
                            }
                        }
                        .frame(height: 350)
                        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))

                        // Image Indicator
                        if images.count >= 1 {
                            Text("\(currentIndex + 1)/\(images.count)")
                                .font(.body)
                                .foregroundColor(Color("App_Primary"))
                                .cornerRadius(8)
                                .frame(maxWidth: .infinity, alignment: .center)
                                .offset(y: 150)
                        }
                    }
                } else {
                    PlaceholderView()
                        .frame(height: 300)
                }

                // Gift Details
                Text(gift.name)
                    .font(.largeTitle)
                    .bold()

                Text(gift.description)
                    .font(.body)

                Text("Category: \(gift.category.rawValue.capitalized)")
                    .font(.caption)
                    .foregroundColor(.secondary)

                Text("Value: $\(gift.value, specifier: "%.2f")")
                    .font(.body)
                    .foregroundColor(Color.blue)

                // Swap Status Badge (Using Reusable View)
                SwapStatusView(status: gift.swapStatus)

                
                // External Store Link (if available)
                VStack {
                                    if let storeLink = gift.storeLink, let url = URL(string: storeLink) {
                                        Link(destination: url) {
                                            Text("View in Store")
                                                .font(.caption)
                                            .foregroundColor(Color.blue)
                                        }
                                    }
                }
                
                CTAButton(
                            label: "Swap With A Gift In Your Basket",
                                    backgroundColor: Color("App_Primary"),
                                    action: {
                                        print("Gift Swap!")
                                    },
                                    icon: Image(systemName: "arrow.triangle.swap")
                                )
                                .padding(.vertical)
                                .disabled(gift.swapStatus != .available)
                                .opacity(gift.swapStatus == .available ? 1 : 0.5)
            }
            .padding()
        }
        .toolbar {
            TopNav(isRootView: false)
        }
        .padding(.vertical, 10)
    }

    
    // Placeholder
    struct PlaceholderView: View {
        var body: some View {
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white)
                .frame(height: 300)
                .overlay(
                    Image(systemName: "gift.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .foregroundColor(Color("App_Primary"))
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color("App_Primary"), lineWidth: 1)
                )
                .shadow(radius: 4)
        }
    }
}
    // Preview
    struct GiftDetailView_Previews: PreviewProvider {
        static var previews: some View {
            NavigationView {
                GiftDetailView(gift: Gift(
                    name: "Luxury Watch",
                    description: "A sleek and stylish timepiece for any occasion.",
                    imageURLs: ["https://picsum.photos/300/200", "https://picsum.photos/300/200"],
                    value: 199.99,
                    isAvailable: true,
                    storeLink: "https://store.com/luxury-watch",
                    category: .fashion,
                    ownerId: UUID(),
                    swapStatus: .available,
                    addedAt: Date()
                ))
            }
        }
    }
    
