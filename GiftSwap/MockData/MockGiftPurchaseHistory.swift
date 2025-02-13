//
//  MockGiftPurchaseHistory.swift
//  GiftSwap
//
//  Created by Handerson COQ on 2/1/25.
//

import Foundation

struct MockGiftPurchaseHistory {
    static var purchaseHistory: [GiftPurchaseHistory] = [
        GiftPurchaseHistory(
            buyerId: MockUsers.users[0].id,
            recipientId: MockUsers.users[1].id,
            occasion: "Birthday",
            giftId: MockSwapGifts.gifts[1].id, // Amazon Echo Spot
            purchasedAt: Date(),
            storeLink: MockSwapGifts.gifts[1].storeLink,
            priceAtPurchase: MockSwapGifts.gifts[1].value
        ),
        GiftPurchaseHistory(
            buyerId: MockUsers.users[2].id,
            recipientId: MockUsers.users[3].id,
            occasion: "Anniversary",
            giftId: MockSwapGifts.gifts[2].id, // Handmade Leather Wallet
            purchasedAt: Date().addingTimeInterval(-86400 * 7), // Purchased 7 days ago
            storeLink: MockSwapGifts.gifts[2].storeLink,
            priceAtPurchase: MockSwapGifts.gifts[2].value
        ),
        GiftPurchaseHistory(
            buyerId: MockUsers.users[4].id,
            recipientId: MockUsers.users[0].id,
            occasion: "Christmas",
            giftId: MockSwapGifts.gifts[4].id, // Personalized Notebook
            purchasedAt: Date().addingTimeInterval(-86400 * 30), // Purchased 30 days ago
            storeLink: MockSwapGifts.gifts[4].storeLink,
            priceAtPurchase: MockSwapGifts.gifts[4].value
        ),
        GiftPurchaseHistory(
            buyerId: MockUsers.users[1].id,
            recipientId: MockUsers.users[2].id,
            occasion: "Wedding",
            giftId: MockSwapGifts.gifts[0].id, // Octo Finissimo Watch
            purchasedAt: Date().addingTimeInterval(-86400 * 60), // Purchased 60 days ago
            storeLink: MockSwapGifts.gifts[0].storeLink,
            priceAtPurchase: MockSwapGifts.gifts[0].value
        ),
        GiftPurchaseHistory(
            buyerId: MockUsers.users[3].id,
            recipientId: MockUsers.users[4].id,
            occasion: "Graduation",
            giftId: MockSwapGifts.gifts[3].id, // Aromatic Scented Candles
            purchasedAt: Date().addingTimeInterval(-86400 * 90), // Purchased 90 days ago
            storeLink: MockSwapGifts.gifts[3].storeLink,
            priceAtPurchase: MockSwapGifts.gifts[3].value
        )
    ]
}

