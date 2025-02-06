//
//  MockGiftPurchaseHistory.swift
//  GiftSwap
//
//  Created by Handerson COQ on 2/1/25.
//

import Foundation

struct MockGiftPurchaseHistory {
    static let purchaseHistory: [GiftPurchaseHistory] = [
        GiftPurchaseHistory(
            buyerId: MockUsers.users[0].id,
            recipientId: MockUsers.users[1].id,
            occasion: "Birthday",
            giftId: MockGifts.gifts[1].id, // Amazon Echo Spot
            purchasedAt: Date(),
            storeLink: MockGifts.gifts[1].storeLink,
            priceAtPurchase: MockGifts.gifts[1].value
        ),
        GiftPurchaseHistory(
            buyerId: MockUsers.users[2].id,
            recipientId: MockUsers.users[3].id,
            occasion: "Anniversary",
            giftId: MockGifts.gifts[2].id, // Handmade Leather Wallet
            purchasedAt: Date().addingTimeInterval(-86400 * 7), // Purchased 7 days ago
            storeLink: MockGifts.gifts[2].storeLink,
            priceAtPurchase: MockGifts.gifts[2].value
        ),
        GiftPurchaseHistory(
            buyerId: MockUsers.users[4].id,
            recipientId: MockUsers.users[0].id,
            occasion: "Christmas",
            giftId: MockGifts.gifts[4].id, // Personalized Notebook
            purchasedAt: Date().addingTimeInterval(-86400 * 30), // Purchased 30 days ago
            storeLink: MockGifts.gifts[4].storeLink,
            priceAtPurchase: MockGifts.gifts[4].value
        ),
        GiftPurchaseHistory(
            buyerId: MockUsers.users[1].id,
            recipientId: MockUsers.users[2].id,
            occasion: "Wedding",
            giftId: MockGifts.gifts[0].id, // Octo Finissimo Watch
            purchasedAt: Date().addingTimeInterval(-86400 * 60), // Purchased 60 days ago
            storeLink: MockGifts.gifts[0].storeLink,
            priceAtPurchase: MockGifts.gifts[0].value
        ),
        GiftPurchaseHistory(
            buyerId: MockUsers.users[3].id,
            recipientId: MockUsers.users[4].id,
            occasion: "Graduation",
            giftId: MockGifts.gifts[3].id, // Aromatic Scented Candles
            purchasedAt: Date().addingTimeInterval(-86400 * 90), // Purchased 90 days ago
            storeLink: MockGifts.gifts[3].storeLink,
            priceAtPurchase: MockGifts.gifts[3].value
        )
    ]
}

