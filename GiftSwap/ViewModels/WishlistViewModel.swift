//
//  WishlistViewModel.swift
//  GiftSwap
//
//  Created by Handerson COQ on 2/10/25.
//

import SwiftUI
import Combine

class WishlistViewModel: ObservableObject {
    @Published var giftsByCategory: [GiftCategory: [WishGift]] = [:]
    private var allGiftsByCategory: [GiftCategory: [WishGift]] = [:]
    @Published var isLoading: Bool = false
    @Published var searchText: String = ""

    private var cancellables = Set<AnyCancellable>()

    init() {
        fetchWishlistGifts()
    }

    // Fetch wishlist gifts and group them by category
    func fetchWishlistGifts() {
        WishGiftService.shared.fetchWishGifts()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print("Error fetching wishlist gifts: \(error.localizedDescription)")
                }
            }, receiveValue: { fetchedGifts in
                // Group gifts by category
                self.allGiftsByCategory = Dictionary(grouping: fetchedGifts, by: { $0.category })
                
                self.filterGifts()
            })
            .store(in: &cancellables)
    }

    // Remove a gift from the wishlist
    func removeGift(_ gift: WishGift) {
        WishGiftService.shared.deleteWishGift(id: gift.id)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print("Error removing gift: \(error.localizedDescription)")
                }
            }, receiveValue: { success in
                if success {
                    self.giftsByCategory[gift.category]?.removeAll { $0.id == gift.id }
                }
            })
            .store(in: &cancellables)
    }
    
    // Filter gifts based on search input
    func filterGifts() {
        if searchText.isEmpty {
            giftsByCategory = allGiftsByCategory
        } else {
            giftsByCategory = allGiftsByCategory.mapValues { gifts in
                gifts.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
            }.filter { !$0.value.isEmpty }
        }
    }

    // Refresh wishlist
    
    func refreshWishlist() {
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.fetchWishlistGifts()
            self.isLoading = false
        }
    }

}
