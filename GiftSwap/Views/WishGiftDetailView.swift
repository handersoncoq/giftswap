//
//  WishGiftDetailView.swift
//  GiftSwap
//
//  Created by Handerson COQ on 2/10/25.
//

import SwiftUI
import Combine

struct WishGiftDetailView: View {
    let gift: WishGift
    @ObservedObject var viewModel: WishGiftFormViewModel
    @State private var currentIndex: Int = 0
    @State private var showConfirmation = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        MainLayoutView(isRootView: false) {
            ScrollView {
                VStack(alignment: .leading, spacing: 14) {
                    WishGiftImageCarousel(gift: gift, currentIndex: $currentIndex)
                    WishGiftDetails(gift: gift)
                    RemoveGiftButton()
                }
                .padding()
            }
            .navigationBarBackButtonHidden(true)
            .alert(alertMessage, isPresented: $showAlert) {
                Button("OK", role: .cancel) { }
            }
            .confirmationDialog("Are you sure you want to remove \(gift.name) from your wishlist?", isPresented: $showConfirmation, titleVisibility: .visible) {
                Button("Remove", role: .destructive) {
                    removeGiftFromWishlist()
                }
                Button("Cancel", role: .cancel) { }
            }
        }
    }

    // MARK: - Remove Gift Button
    @ViewBuilder
    private func RemoveGiftButton() -> some View {
        CTAButton(
            label: "Remove from \(viewModel.wishlist.name)",
            backgroundColor: .red,
            action: {
                showConfirmation = true
            },
            icon: Image(systemName: "trash")
        )
        .padding(.bottom, 45)
        .padding(.top, 8)
    }

    // MARK: - Remove Gift Logic
    private func removeGiftFromWishlist() {
        viewModel.removeGift(gift)
        alertMessage = "Gift \"\(gift.name)\" has been removed from your wishlist."
        showAlert = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            presentationMode.wrappedValue.dismiss()
        }
    }
}

// MARK: - Gift Images
struct WishGiftImageCarousel: View {
    let gift: WishGift
    @Binding var currentIndex: Int

    var body: some View {
        if let imageURLs = gift.imageURLs, !imageURLs.isEmpty {
            ZStack {
                TabView(selection: $currentIndex) {
                    ForEach(imageURLs.indices, id: \.self) { index in
                        AsyncImage(url: URL(string: imageURLs[index])) { phase in
                            switch phase {
                            case .empty:
                                ProgressView().frame(height: 300)
                            case .success(let image):
                                image.resizable()
                                    .frame(maxWidth: 450, maxHeight: 270)
                                    .cornerRadius(16)
                            case .failure:
                                WishGiftPlaceholderView().frame(height: 300)
                            @unknown default:
                                EmptyView()
                            }
                        }
                        .tag(index)
                    }
                }
                .frame(height: 270)
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))

                
                if imageURLs.count > 1 {
                    Text("\(currentIndex + 1)/\(imageURLs.count)")
                        .font(.body)
                        .foregroundColor(Color("App_Primary"))
                        .frame(maxWidth: .infinity, alignment: .center)
                        .offset(y: 152)
                }
            }
            .padding(.bottom, 30)
        } else {
            WishGiftPlaceholderView().frame(height: 300)
        }
    }

}

// MARK: - Gift Details
struct WishGiftDetails: View {
    let gift: WishGift

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(gift.name)
                .font(.largeTitle)
                .bold()

            Text(gift.description)
                .font(.body)

            if let brand = gift.brand {
                Text("Brand: \(brand)")
                    .font(.body)
                    .foregroundColor(.gray)
            }
            
            HStack {
                // Display price if available
                if let price = gift.price {
                    Text("Price: \(gift.currency ?? "0") \(price, specifier: "%.2f")")
                        .font(.body)
                        .foregroundColor(Color.blue)
                } else {
                    Text("Price: Unavailable")
                        .font(.body)
                        .foregroundColor(.gray)
                }

                if let storeLink = gift.storeLink, !storeLink.isEmpty, let url = URL(string: storeLink) {
                    Link(destination: url) {
                        Image(systemName: "link")
                            .foregroundColor(.blue)
                            .padding(.leading, 5)
                    }
                }

            }


           
        }
    }
}

// MARK: - Placeholder Image
struct WishGiftPlaceholderView: View {
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

struct WishGiftDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            WishGiftDetailView(
                gift: WishGift(
                    id: UUID(),
                    name: "Luxury Handbag",
                    description: "A premium leather handbag with an elegant design.",
                    category: .fashion,
                    images: ["https://picsum.photos/300/200", "https://picsum.photos/300/200"],
                    storeLink: "https://store.com/luxury-handbag",
                    price: 249.99,
                    currency: "USD",
                    brand: "Designer Brand",
                    wishListId: UUID()
                ),
                viewModel: WishGiftFormViewModel(wishlist: Wishlist(
                    id: UUID(),
                    userId: UUID(),
                    name: "Birthday Wishlist",
                    description: "A list of birthday gift ideas",
                    isPrivate: false,
                    isActive: true,
                    category: .birthday,
                    addedAt: Date()
                ))
            )
        }
    }
}


