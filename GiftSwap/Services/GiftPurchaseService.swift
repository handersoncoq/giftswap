//
//  GiftPurchaseService.swift
//  GiftSwap
//
//  Created by Handerson COQ on 2/1/25.
//

import Foundation
import Combine

class GiftPurchaseService {
    static let shared = GiftPurchaseService()
    private init() {}

    // Use mock data from MockGiftPurchaseHistory
    private var purchaseHistory: [GiftPurchaseHistory] = MockGiftPurchaseHistory.purchaseHistory

    // Fetch all gift purchases
    func fetchGiftPurchases() -> AnyPublisher<[GiftPurchaseHistory], Error> {
        return Just(purchaseHistory)
            .delay(for: .seconds(1), scheduler: RunLoop.main)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    // Fetch gift purchase history for a buyer
    func fetchGiftPurchases(forBuyerId buyerId: UUID) -> AnyPublisher<[GiftPurchaseHistory], Error> {
        let buyerPurchases = purchaseHistory.filter { $0.buyerId == buyerId }

        return Just(buyerPurchases)
            .delay(for: .seconds(1), scheduler: RunLoop.main)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    // Fetch gift purchases for a recipient
    func fetchGiftPurchases(forRecipientId recipientId: UUID) -> AnyPublisher<[GiftPurchaseHistory], Error> {
        let recipientPurchases = purchaseHistory.filter { $0.recipientId == recipientId }

        return Just(recipientPurchases)
            .delay(for: .seconds(1), scheduler: RunLoop.main)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    // Fetch gift purchases by occasion
    func fetchGiftPurchases(byOccasion occasion: String) -> AnyPublisher<[GiftPurchaseHistory], Error> {
        let occasionPurchases = purchaseHistory.filter { $0.occasion?.lowercased() == occasion.lowercased() }

        return Just(occasionPurchases)
            .delay(for: .seconds(1), scheduler: RunLoop.main)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    // Add a new gift purchase (mock persistence)
    func addGiftPurchase(_ purchase: GiftPurchaseHistory) -> AnyPublisher<GiftPurchaseHistory, Error> {
        purchaseHistory.append(purchase)

        return Just(purchase)
            .delay(for: .seconds(1), scheduler: RunLoop.main)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    // Update a gift purchase (mock persistence)
    func updateGiftPurchase(_ updatedPurchase: GiftPurchaseHistory) -> AnyPublisher<GiftPurchaseHistory, Error> {
        if let index = purchaseHistory.firstIndex(where: { $0.id == updatedPurchase.id }) {
            purchaseHistory[index] = updatedPurchase
            return Just(updatedPurchase)
                .delay(for: .seconds(1), scheduler: RunLoop.main)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } else {
            return Fail(error: NSError(domain: "GiftPurchaseService", code: 404, userInfo: [NSLocalizedDescriptionKey: "Gift purchase record not found"]))
                .eraseToAnyPublisher()
        }
    }

    // Delete a gift purchase record (mock persistence)
    func deleteGiftPurchase(id: UUID) -> AnyPublisher<Bool, Error> {
        if let index = purchaseHistory.firstIndex(where: { $0.id == id }) {
            purchaseHistory.remove(at: index)
            return Just(true)
                .delay(for: .seconds(1), scheduler: RunLoop.main)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } else {
            return Fail(error: NSError(domain: "GiftPurchaseService", code: 404, userInfo: [NSLocalizedDescriptionKey: "Gift purchase record not found"]))
                .eraseToAnyPublisher()
        }
    }
}
