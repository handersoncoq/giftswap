//
//  SwapBasketService.swift
//  GiftSwap
//
//  Created by Handerson COQ on 2/1/25.
//

import Foundation
import Combine

class SwapBasketService {
    static let shared = SwapBasketService() // Singleton instance
    private init() {}

    private var swapBaskets: [SwapBasket] = MockSwapBaskets.swapBaskets

    // Fetch all swap baskets
    func fetchSwapBaskets() -> AnyPublisher<[SwapBasket], Error> {
        return Just(swapBaskets)
            .delay(for: .seconds(1), scheduler: RunLoop.main)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    // Fetch all gifts currently in swap baskets using `GiftService`
    func fetchAllGiftsInSwapBaskets() -> AnyPublisher<[Gift], Error> {
        let giftIdsInSwapBaskets = swapBaskets.map { $0.giftId }

        return GiftService.shared.fetchGifts()
            .map { allGifts in
                allGifts.filter { giftIdsInSwapBaskets.contains($0.id) }
            }
            .eraseToAnyPublisher()
    }
    
    // Fetch swap basket gifts for a specific user
    func fetchUserSwapBasketGifts(userId: UUID) -> AnyPublisher<[Gift], Error> {
        return fetchAllGiftsInSwapBaskets()
            .map { allGifts in
                allGifts.filter { $0.ownerId == userId }
            }
            .eraseToAnyPublisher()
    }

    
    // TEMPORARY: add gift to swap basket
    
    func addGiftToSwapBasket(_ swapBasketItem: SwapBasket) {
        swapBaskets.append(swapBasketItem)
    }
    
    // update status
    func updateSwapStatus(for giftId: UUID, to newStatus: SwapStatus) {
        if let index = swapBaskets.firstIndex(where: { $0.id == giftId }) {
            swapBaskets[index].status = newStatus
        }
    }


    // Remove a gift from the swap basket
        func removeGiftFromSwapBasket(giftId: UUID) -> AnyPublisher<Bool, Error> {
            if let index = swapBaskets.firstIndex(where: { $0.giftId == giftId }) {
                swapBaskets.remove(at: index)
                return Just(true)
                    .delay(for: .seconds(1), scheduler: RunLoop.main)
                    .setFailureType(to: Error.self)
                    .eraseToAnyPublisher()
            } else {
                return Fail(error: NSError(domain: "SwapBasketService", code: 404, userInfo: [NSLocalizedDescriptionKey: "Gift not found in Swap Basket"]))
                    .eraseToAnyPublisher()
            }
        }
}

