//
//  GiftListViewModel.swift
//  GiftSwap
//
//  Created by Handerson COQ on 1/27/25.
//

import Foundation
import Combine
import UserNotifications

@MainActor
class MarketplaceViewModel: ObservableObject {
    @Published var gifts: [SwapGift] = []
    @Published var searchText: String = ""
    @Published var displayedGifts: [SwapGift] = []
    @Published var giftsByCategory: [GiftCategory: [SwapGift]] = [:]

    private var cancellables = Set<AnyCancellable>()

    var availableCategories: [GiftCategory] {
        giftsByCategory.keys.sorted { $0.rawValue < $1.rawValue }
    }

    var filteredGifts: [SwapGift] {
        if searchText.isEmpty {
            return gifts
        } else {
            return gifts.filter { gift in
                gift.name.localizedCaseInsensitiveContains(searchText) ||
                gift.description.localizedCaseInsensitiveContains(searchText)
            }
        }
    }

    var filteredGiftsByCategory: [GiftCategory: [SwapGift]] {
        if searchText.isEmpty {
            return giftsByCategory
        } else {
            return giftsByCategory.mapValues { gifts in
                gifts.filter { gift in
                    gift.name.localizedCaseInsensitiveContains(searchText) ||
                    gift.description.localizedCaseInsensitiveContains(searchText)
                }
            }
        }
    }

    init() {
        fetchGiftsFromSwapBasket()
    }

    func fetchGiftsFromSwapBasket() {
        SwapBasketService.shared.fetchAllGiftsInSwapBaskets()
            .map { (gifts: [SwapGift]) -> [SwapGift] in
                // Exclude gifts that belong to the current user
                guard let currentUser = AuthService.shared.currentUser else { return [] }
                return gifts.filter { $0.ownerId != currentUser.id }
            }
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error fetching swap basket gifts: \(error)")
                }
            }, receiveValue: { [weak self] (filteredGifts: [SwapGift]) in
                self?.gifts = filteredGifts
                self?.groupGiftsByCategory(filteredGifts)
            })
            .store(in: &cancellables)
    }


    func groupGiftsByCategory(_ gifts: [SwapGift]) {
        giftsByCategory = Dictionary(grouping: gifts, by: { $0.category })
    }

    func loadCategoryGifts(category: GiftCategory) {
        displayedGifts = giftsByCategory[category] ?? []
    }

    func categoryIcon(for category: GiftCategory) -> String {
        switch category {
        case .fashion: return "tshirt"
        case .electronics: return "desktopcomputer"
        case .home: return "house"
        case .books: return "book"
        case .toys: return "gamecontroller"
        case .beauty: return "theatermask.and.paintbrush"
        default: return "gift"
        }
    }
}



