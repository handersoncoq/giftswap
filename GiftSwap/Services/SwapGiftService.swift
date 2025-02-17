//
//  SwapGiftService.swift
//  GiftSwap
//
//  Created by Handerson COQ on 1/27/25.
//

import Foundation
import Combine

class SwapGiftService {
    static let shared = SwapGiftService() // Singleton instance
    private init() {}

    // Mock data for now
    private var gifts: [SwapGift] {
        get { MockSwapGifts.gifts }
        set { MockSwapGifts.gifts = newValue }
    }
    
    func getGift(by id: UUID) -> SwapGift? {
        return gifts.first { $0.id == id }
    }


    // Fetch gifts with optional filters (availability, category, owner)
    func fetchGifts(isAvailable: Bool? = nil, category: GiftCategory? = nil, ownerId: UUID? = nil) -> AnyPublisher<[SwapGift], Error> {
        var filteredGifts = gifts

        if let isAvailable = isAvailable {
            filteredGifts = filteredGifts.filter { $0.isAvailable == isAvailable }
        }

        if let category = category {
            filteredGifts = filteredGifts.filter { $0.category == category }
        }

        if let ownerId = ownerId {
            filteredGifts = filteredGifts.filter { $0.ownerId == ownerId }
        }

        return Just(filteredGifts)
            .delay(for: .seconds(1), scheduler: RunLoop.main) // Simulate network delay
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    // Add a new gift (mock persistence)
    func addGift(_ gift: SwapGift) -> AnyPublisher<SwapGift, Error> {
        // Append to mock data
        gifts.append(gift)

        // If the user has a swap basket, add the gift to it
        if let userIndex = MockUsers.mutableUsers.firstIndex(where: { $0.id == gift.ownerId }) {
            MockUsers.mutableUsers[userIndex].swapBasket?.append(SwapBasket(userId: gift.ownerId, giftId: gift.id, status: .available))
        } else {
            return Fail(error: NSError(domain: "SwapGiftService", code: 404, userInfo: [NSLocalizedDescriptionKey: "User not found"]))
                .eraseToAnyPublisher()
        }

        return Just(gift)
            .delay(for: .seconds(1), scheduler: RunLoop.main)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }


    // Update a gift (mock persistence)
    func updateGift(_ updatedGift: SwapGift) -> AnyPublisher<SwapGift, Error> {
        if let index = gifts.firstIndex(where: { $0.id == updatedGift.id }) {
            gifts[index] = updatedGift
            return Just(updatedGift)
                .delay(for: .seconds(1), scheduler: RunLoop.main)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } else {
            return Fail(error: NSError(domain: "GiftService", code: 404, userInfo: [NSLocalizedDescriptionKey: "Gift not found"]))
                .eraseToAnyPublisher()
        }
    }


    // Delete a gift (mock persistence)
    func deleteGift(id: UUID) -> AnyPublisher<Bool, Error> {
        if let index = gifts.firstIndex(where: { $0.id == id }) {
            gifts.remove(at: index)
            return Just(true)
                .delay(for: .seconds(1), scheduler: RunLoop.main)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } else {
            return Fail(error: NSError(domain: "GiftService", code: 404, userInfo: [NSLocalizedDescriptionKey: "Gift not found"]))
                .eraseToAnyPublisher()
        }
    }


}

