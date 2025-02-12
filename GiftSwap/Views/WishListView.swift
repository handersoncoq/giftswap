//
//  WishListView.swift
//  GiftSwap
//
//  Created by Handerson COQ on 2/11/25.
//

import SwiftUI

struct WishlistView: View {
    @StateObject private var viewModel = WishlistViewModel()
    @State private var showAddWishlist = false
    @State private var wishlistToRemove: Wishlist?
    @State private var showConfirmation = false

    var body: some View {
        MainLayoutView(isRootView: false) {
            VStack(alignment: .leading) {
                titleView
                searchBar

                if viewModel.isLoading {
                    ProgressView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .padding(.top, 50)
                } else if viewModel.wishlistsByCategory.isEmpty {
                    emptyMessage
                } else {
                    wishlistList
                }
            }
            .padding(.horizontal)
            .navigationBarBackButtonHidden(true)
            .alert("Are you sure you want to delete this wishlist?", isPresented: $showConfirmation) {
                Button("Delete", role: .destructive) {
                    if let wishlist = wishlistToRemove {
                        viewModel.removeWishlist(wishlist)
                    }
                }
                Button("Cancel", role: .cancel) { }
            }
        }
    }

    private var titleView: some View {
        HStack {
            Text("My Wishlists")
                .font(.largeTitle)
                .bold()

            Spacer()

            Button(action: { showAddWishlist = true }) {
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

            TextField("Search wishlists...", text: $viewModel.searchText)
                .onChange(of: viewModel.searchText) { _, _ in
                    viewModel.filterWishlists()
                }
        }
        .padding(10)
        .background(Color("App_Primary").opacity(0.06))
        .cornerRadius(10)
        .padding(.bottom, 20)
    }

    private var wishlistList: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 16) {
                ForEach(viewModel.wishlistsByCategory.keys.sorted(by: { $0.rawValue < $1.rawValue }), id: \.self) { category in
                    if let wishlists = viewModel.wishlistsByCategory[category] {
                        Section(header: Text(category.rawValue.capitalized).font(.headline).bold()) {
                            ForEach(wishlists) { wishlist in
                                NavigationLink(destination: WishListDetailView(wishlist: wishlist)) {
                                    WishlistCard(
                                        wishlist: wishlist,
                                        onDelete: {
                                            wishlistToRemove = wishlist
                                            showConfirmation = true
                                        }
                                    )
                                    .padding(.horizontal)
                                }
                            }
                        }
                    }
                }
            }
            .padding(.bottom, 50)
        }
    }


    private var emptyMessage: some View {
        VStack(spacing: 10) {
            Text("You have no wishlists yet.")
                .font(.title3)
                .bold()
                .foregroundColor(.black.opacity(0.8))

            Text("Create a wishlist for special occasions.")
                .font(.body)
                .foregroundColor(.black.opacity(0.7))
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .padding(.top, 50)
    }
    
}

#Preview {
    WishlistView()
}
