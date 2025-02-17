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
    func fetchAllGiftsInSwapBaskets() -> AnyPublisher<[SwapGift], Error> {
        let giftIdsInSwapBaskets = swapBaskets.map { $0.giftId }

        return SwapGiftService.shared.fetchGifts()
            .map { allGifts in
                allGifts.filter { giftIdsInSwapBaskets.contains($0.id) }
            }
            .eraseToAnyPublisher()
    }
    
    func fetchUserSwapBasketGifts(userId: UUID) -> AnyPublisher<[SwapGift], Error> {
           let userGiftIds = swapBaskets.filter { $0.userId == userId }.map { $0.giftId }

           return SwapGiftService.shared.fetchGifts()
               .map { allGifts in
                   allGifts.filter { userGiftIds.contains($0.id) }
               }
               .eraseToAnyPublisher()
       }

    
    // TEMPORARY: add gift to swap basket
    
    func addGiftToSwapBasket(_ swapBasketItem: SwapBasket) {
        swapBaskets.append(swapBasketItem)
        MockSwapBaskets.swapBaskets.append(swapBasketItem)
    }

    // update status
    func updateSwapStatus(for giftId: UUID, to newStatus: SwapStatus) -> AnyPublisher<Bool, Error> {
        if let index = swapBaskets.firstIndex(where: { $0.giftId == giftId }) {
            swapBaskets[index].status = newStatus
            MockSwapBaskets.swapBaskets = swapBaskets

            if var updatedGift = SwapGiftService.shared.getGift(by: giftId) {
                updatedGift.swapStatus = newStatus
                
                return SwapGiftService.shared.updateGift(updatedGift)
                    .map { _ in true } 
                    .eraseToAnyPublisher()
            } else {
                return Fail(error: NSError(domain: "SwapBasketService", code: 404, userInfo: [NSLocalizedDescriptionKey: "Gift not found"]))
                    .eraseToAnyPublisher()
            }
        } else {
            return Fail(error: NSError(domain: "SwapBasketService", code: 404, userInfo: [NSLocalizedDescriptionKey: "Gift not found in Swap Basket"]))
                .eraseToAnyPublisher()
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

