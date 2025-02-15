//
//  WishlistViewModel.swift
//  GiftSwap
//
//  Created by Handerson COQ on 2/10/25.
//

import Foundation
import Combine

class WishlistViewModel: ObservableObject {
    @Published var wishlists: [Wishlist] = []
    @Published var wishlistsByCategory: [WishlistCategory: [Wishlist]] = [:]
    @Published var isLoading = false
    @Published var searchText: String = ""

    private var cancellables = Set<AnyCancellable>()

    init() {
        fetchUserWishlists()
    }

    func fetchUserWishlists() {
        guard let currentUser = AuthService.shared.currentUser else {
            print("No logged-in user found.")
            return
        }

        isLoading = true
        WishlistService.shared.fetchWishlists(forUserId: currentUser.id)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { _ in
                self.isLoading = false
            }, receiveValue: { wishlists in
                self.wishlists = wishlists
                self.groupWishlistsByCategory()
            })
            .store(in: &cancellables)
    }

    private func groupWishlistsByCategory() {
        wishlistsByCategory = Dictionary(grouping: wishlists, by: { $0.category })
    }

    func filterWishlists() {
        guard !searchText.isEmpty else {
            groupWishlistsByCategory()
            return
        }
        let filtered = wishlists.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        wishlistsByCategory = Dictionary(grouping: filtered, by: { $0.category })
    }

    func removeWishlist(_ wishlist: Wishlist) {
        WishlistService.shared.deleteWishlist(id: wishlist.id)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print("Error deleting wishlist: \(error.localizedDescription)")
                }
            }, receiveValue: { success in
                if success {
                    self.wishlists.removeAll { $0.id == wishlist.id }
                    self.groupWishlistsByCategory()
                }
            })
            .store(in: &cancellables)
    }

    // Refresh wishlists with loading state
    func refreshWishlists() {
        self.isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.fetchUserWishlists()
            self.isLoading = false
        }
    }
}

