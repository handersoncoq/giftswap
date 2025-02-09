//
//  SwapGiftDetailView.swift
//  GiftSwap
//
//  Created by Handerson COQ on 2/8/25.
//

import SwiftUI
import Combine


struct SwapGiftDetailView: View {
    let gift: Gift
    @ObservedObject var viewModel: SwapBasketViewModel
    @State private var currentIndex: Int = 0
    @State private var showConfirmation = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        MainLayoutView(isRootView: false) {
            ScrollView {
                VStack(alignment: .leading, spacing: 14) {
                    GiftImageCarousel(gift: gift, currentIndex: $currentIndex)
                    GiftDetails(gift: gift)
                    SwapStatusView(status: gift.swapStatus)
                    RemoveGiftButton()
                }
                .padding()
            }
            .navigationBarBackButtonHidden(true)
            .alert(alertMessage, isPresented: $showAlert) {
                Button("OK", role: .cancel) { }
            }
            .confirmationDialog("Are you sure you want to remove \(gift.name) from your swap basket?", isPresented: $showConfirmation, titleVisibility: .visible) {
                Button("Remove", role: .destructive) {
                    removeGiftFromSwapBasket()
                }
                Button("Cancel", role: .cancel) { }
            }
        }
    }

    // Remove gift button
    @ViewBuilder
    private func RemoveGiftButton() -> some View {
        CTAButton(
            label: "Remove from Swap Basket",
            backgroundColor: .red,
            action: {
                if gift.swapStatus == .pending {
                    alertMessage = "This gift's swap status is currently pending and cannot be removed."
                    showAlert = true
                } else {
                    showConfirmation = true
                }
            },
            icon: Image(systemName: "trash")
        )
        .padding(.bottom, 45)
        .padding(.top, 8)
    }

    // Remove Gift
    private func removeGiftFromSwapBasket() {
        viewModel.removeGift(gift)
        alertMessage = "Gift \"\(gift.name)\" has been removed from your swap basket."
        showAlert = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            presentationMode.wrappedValue.dismiss()
        }
    }
}

// Gift Images
struct GiftImageCarousel: View {
    let gift: Gift
    @Binding var currentIndex: Int

    var body: some View {
        if let images = gift.imageURLs, !images.isEmpty {
            ZStack {
                TabView(selection: $currentIndex) {
                    ForEach(images.indices, id: \.self) { index in
                        AsyncImage(url: URL(string: images[index])) { phase in
                            switch phase {
                            case .empty:
                                ProgressView().frame(height: 300)
                            case .success(let image):
                                image.resizable().frame(maxWidth: 450).frame(height: 270).cornerRadius(16)
                            case .failure:
                                PlaceholderView().frame(height: 300)
                            @unknown default:
                                EmptyView()
                            }
                        }
                        .tag(index)
                    }
                }
                .frame(height: 270)
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))

                // Image Indicator
                if images.count >= 1 {
                    Text("\(currentIndex + 1)/\(images.count)")
                        .font(.body)
                        .foregroundColor(Color("App_Primary"))
                        .frame(maxWidth: .infinity, alignment: .center)
                        .offset(y: 152)
                }
            }
            .padding(.bottom, 30)
        } else {
            PlaceholderView().frame(height: 300)
        }
    }
}

// Gift Details
struct GiftDetails: View {
    let gift: Gift

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(gift.name)
                .font(.largeTitle)
                .bold()

            Text(gift.description)
                .font(.body)

            Text("Category: \(gift.category.rawValue.capitalized)")
                .font(.caption)
                .foregroundColor(.secondary)

            HStack {
                Text("Value: $\(gift.value, specifier: "%.2f")")
                    .font(.body)
                    .foregroundColor(Color.blue)

                if let storeLink = gift.storeLink, let url = URL(string: storeLink) {
                    Link(destination: url) {
                        Image(systemName: "link")
                    }
                }
            }
        }
    }
}

// Placeholder Image
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




// Preview
struct SwapGiftDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SwapGiftDetailView(gift: Gift(
                name: "Luxury Watch",
                description: "A sleek and stylish timepiece for any occasion.",
                imageURLs: ["https://picsum.photos/300/200", "https://picsum.photos/300/200"],
                value: 199.99,
                isAvailable: true,
                storeLink: "https://store.com/luxury-watch",
                category: .fashion,
                ownerId: UUID(),
                swapStatus: .inBasket,
                addedAt: Date()
            ), viewModel: SwapBasketViewModel())
        }
    }
}
