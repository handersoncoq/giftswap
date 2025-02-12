//
//  WishlistViewModel.swift
//  GiftSwap
//
//  Created by Handerson COQ on 2/10/25.
//

import SwiftUI
import Combine

class WishlistViewModel: ObservableObject {
    @Published var wishlistsByCategory: [WishlistCategory: [Wishlist]] = [:]
    private var allWishlistsByCategory: [WishlistCategory: [Wishlist]] = [:]
    @Published var isLoading: Bool = false
    @Published var searchText: String = ""

    private var cancellables = Set<AnyCancellable>()

    init() {
        fetchWishlists()
    }

    // Fetch all wishlists
    func fetchWishlists() {
        isLoading = true
        WishlistService.shared.fetchWishlistsGroupedByCategory()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print("Error fetching wishlists: \(error.localizedDescription)")
                }
                self.isLoading = false
            }, receiveValue: { groupedWishlists in
                self.allWishlistsByCategory = groupedWishlists
                self.filterWishlists()
            })
            .store(in: &cancellables)
    }

    // Add a new wishlist
    func addWishlist(name: String, category: WishlistCategory, isPrivate: Bool) {
        let newWishlist = Wishlist(userId: UUID(), name: name, isPrivate: isPrivate, category: category)

        WishlistService.shared.addWishlist(newWishlist)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print("Error adding wishlist: \(error.localizedDescription)")
                }
            }, receiveValue: { wishlist in
                self.allWishlistsByCategory[wishlist.category, default: []].append(wishlist)
                self.filterWishlists()
            })
            .store(in: &cancellables)
    }

    // Update a wishlist
    func updateWishlist(_ wishlist: Wishlist) {
        WishlistService.shared.updateWishlist(wishlist)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print("Error updating wishlist: \(error.localizedDescription)")
                }
            }, receiveValue: { updatedWishlist in
                if let index = self.allWishlistsByCategory[updatedWishlist.category]?.firstIndex(where: { $0.id == updatedWishlist.id }) {
                    self.allWishlistsByCategory[updatedWishlist.category]?[index] = updatedWishlist
                    self.filterWishlists()
                }
            })
            .store(in: &cancellables)
    }

    // Delete a wishlist
    func removeWishlist(_ wishlist: Wishlist) {
        WishlistService.shared.deleteWishlist(id: wishlist.id)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print("Error removing wishlist: \(error.localizedDescription)")
                }
            }, receiveValue: { success in
                if success {
                    self.allWishlistsByCategory[wishlist.category]?.removeAll { $0.id == wishlist.id }
                    self.filterWishlists()
                }
            })
            .store(in: &cancellables)
    }

    // Filter wishlists based on search text
    func filterWishlists() {
        if searchText.isEmpty {
            wishlistsByCategory = allWishlistsByCategory
        } else {
            wishlistsByCategory = allWishlistsByCategory.mapValues { wishlists in
                wishlists.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
            }.filter { !$0.value.isEmpty }
        }
    }

    // Refresh wishlists with loading state
    func refreshWishlists() {
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.fetchWishlists()
        }
    }
}

