//
//  WishlistView.swift
//  GiftSwap
//
//  Created by Handerson COQ on 2/10/25.
//

import SwiftUI
import Combine

struct WishGiftView: View {
    @StateObject private var viewModel = WishlistViewModel()
    @State private var showConfirmation = false
    @State private var giftToRemove: WishGift?
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var navigateToAddGift = false
    @State private var navigateToCuratedGifts = false
    @State private var expandedCategories: Set<GiftCategory> = []

    var body: some View {
        MainLayoutView(isRootView: false) {
            VStack(alignment: .leading) {
                titleView
                searchBar
                
                if viewModel.isLoading {
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .padding(.top, 50)
                } else if viewModel.giftsByCategory.isEmpty {
                    emptyWishlistMessage
                } else {
                    giftList
                }

                Spacer()
            }
            .onAppear {
                viewModel.refreshWishlist()
            }
            .padding(.horizontal)
            .navigationBarBackButtonHidden(true)
            .alert(alertMessage, isPresented: $showAlert) {
                Button("OK", role: .cancel) { }
            }
            .confirmationDialog(
                confirmationMessage,
                isPresented: $showConfirmation,
                titleVisibility: .visible
            ) {
                removeGiftButton
                cancelButton
            }
        }
        .navigationDestination(isPresented: $navigateToAddGift) {
            AddWishGiftView()
        }
        .navigationDestination(isPresented: $navigateToCuratedGifts) {
            CuratedGifts()
        }
    }

    // MARK: - Subviews

    private var titleView: some View {
        HStack {
            Text("My Wish Gifts")
                .font(.largeTitle)
                .bold()

            Spacer()

            Button(action: { navigateToAddGift = true }) {
                Image(systemName: "plus")
                    .font(.title)
                    .frame(width: 40, height: 40)
                    .background(Color("App_Primary").opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }
        }
        .padding(.vertical)
    }

    private var searchBar: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.black.opacity(0.5))

            TextField("Search gifts...", text: $viewModel.searchText, prompt: Text("Search gifts...")
                .fontWeight(.medium)
                .foregroundColor(.black.opacity(0.5)))
                .onChange(of: viewModel.searchText) { _, _ in
                    viewModel.filterGifts()
                }
        }
        .padding(10)
        .background(Color("App_Primary").opacity(0.06))
        .cornerRadius(10)
        .padding(.bottom, 20)
    }

    private var giftList: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 16) {
                ForEach(viewModel.giftsByCategory.keys.sorted(by: { $0.rawValue < $1.rawValue }), id: \.self) { category in
                    if let gifts = viewModel.giftsByCategory[category] {
                        categorySection(category: category, gifts: gifts)
                    }
                }
            }
            .padding(.top, 20)
            .padding(.bottom, 50)
        }
    }

    private var emptyWishlistMessage: some View {
        VStack(spacing: 10) {
            Text("Your wishlist is empty.")
                .font(.title3)
                .bold()
                .foregroundColor(.black.opacity(0.8))
            
            Text("Consider adding gifts to your wishlist.")
                .font(.body)
                .foregroundColor(.black.opacity(0.7))
            
            Button(action: { navigateToCuratedGifts = true }) {
                Text("Browse our curated gift list")
                    .font(.body)
                    .foregroundColor(Color.blue)
                    .underline()
            }
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .padding(.top, 50)
    }

    private func categorySection(category: GiftCategory, gifts: [WishGift]) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(category.rawValue.capitalized)
                    .font(.headline)
                    .bold()
                Spacer()
            }

            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 12), count: 2), spacing: 12) {
                ForEach(expandedCategories.contains(category) ? gifts : Array(gifts.prefix(4))) { gift in
                    NavigationLink(destination: WishGiftDetailView(gift: gift, viewModel: viewModel)) {
                        WishGiftCard(gift: gift, onRemove: {
                            giftToRemove = gift
                            showConfirmation = true
                        })
                    }
                }
            }

            if gifts.count > 4 {
                Button(action: {
                    if expandedCategories.contains(category) {
                        expandedCategories.remove(category) // Collapse category
                    } else {
                        expandedCategories.insert(category) // Expand category
                    }
                }) {
                    Text(expandedCategories.contains(category) ? "View Less" : "Load More")
                        .font(.body)
                        .foregroundColor(Color.blue)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            }
        }
    }

    // MARK: - Confirmation Dialog

    private var confirmationMessage: String {
        "Are you sure you want to remove \(giftToRemove?.name ?? "") from your wishlist?"
    }

    private var removeGiftButton: some View {
        Button("Remove", role: .destructive) {
            if let gift = giftToRemove {
                viewModel.removeGift(gift)
                alertMessage = "Gift \"\(gift.name)\" has been removed from your wishlist."
                showAlert = true
            }
        }
    }

    private var cancelButton: some View {
        Button("Cancel", role: .cancel) { }
    }
}


// Preview
#Preview {
    WishGiftView()
}
