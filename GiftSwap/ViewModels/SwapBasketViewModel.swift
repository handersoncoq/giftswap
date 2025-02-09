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
    @Published var searchText: String = ""

    private var cancellables = Set<AnyCancellable>()

    init() {
        loadSwapBasket()
    }

    func loadSwapBasket() {
        SwapBasketService.shared.fetchAllGiftsInSwapBaskets()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print("Error fetching swap basket gifts: \(error.localizedDescription)")
                }
            }, receiveValue: { fetchedGifts in
                self.giftsByCategory = Dictionary(grouping: fetchedGifts, by: { $0.category })
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
}
