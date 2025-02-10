//
//  SwapBasketViewModel.swift
//  GiftSwap
//
//  Created by Handerson COQ on 2/8/25.
//

import SwiftUI
import Combine

class SwapBasketViewModel: ObservableObject {
    @Published var giftsByCategory: [GiftCategory: [Gift]] = [:]
    private var allGiftsByCategory: [GiftCategory: [Gift]] = [:]
    @Published var searchText: String = ""
    @Published var pendingSwapRequests: [Gift] = []

    private var cancellables = Set<AnyCancellable>()

    init() {
        fetchSwapBasketGifts()
    }

    func fetchSwapBasketGifts() {
        SwapBasketService.shared.fetchAllGiftsInSwapBaskets()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print("Error fetching swap basket gifts: \(error.localizedDescription)")
                }
            }, receiveValue: { fetchedGifts in
                self.allGiftsByCategory = Dictionary(grouping: fetchedGifts, by: { $0.category })
                self.filterGifts()
            })
            .store(in: &cancellables)
    }

    func removeGift(_ gift: Gift) {
        SwapBasketService.shared.removeGiftFromSwapBasket(giftId: gift.id)
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

    
    
    func refreshSwapBasket() {
        fetchSwapBasketGifts()
        }
}
