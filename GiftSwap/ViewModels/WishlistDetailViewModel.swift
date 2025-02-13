//
//  WishlistDetailViewModel.swift
//  GiftSwap
//
//  Created by Handerson COQ on 2/12/25.
//

import Foundation
import Combine

class WishlistDetailViewModel: ObservableObject {
    @Published var giftsByCategory: [GiftCategory: [WishGift]] = [:]
    private var allGiftsByCategory: [GiftCategory: [WishGift]] = [:]
    @Published var searchText: String = ""
    @Published var isLoading: Bool = false

    private var cancellables = Set<AnyCancellable>()
    let wishlist: Wishlist

    init(wishlist: Wishlist) {
        self.wishlist = wishlist
        fetchWishGifts()
    }

    // Fetch wish gifts for this specific wishlist
    func fetchWishGifts() {
        isLoading = true
        WishGiftService.shared.fetchWishGifts(for: wishlist.id) // ✅ Fetch gifts only for this wishlist
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                self.isLoading = false
                if case .failure(let error) = completion {
                    print("Error fetching wish gifts: \(error.localizedDescription)")
                }
            }, receiveValue: { fetchedGifts in
                print("✅ Successfully fetched \(fetchedGifts.count) gifts for wishlist ID: \(self.wishlist.id)")
                self.allGiftsByCategory = Dictionary(grouping: fetchedGifts, by: { $0.category })
                self.filterGifts()
            })
            .store(in: &cancellables)
    }


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

    func filterGifts() {
        if searchText.isEmpty {
            giftsByCategory = allGiftsByCategory
        } else {
            giftsByCategory = allGiftsByCategory.mapValues { gifts in
                gifts.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
            }.filter { !$0.value.isEmpty }
        }
    }

    func refreshWishGifts() {
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.fetchWishGifts()
            self.isLoading = false
        }
    }
}
