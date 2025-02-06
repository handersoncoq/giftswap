//
//  GiftPurchaseHistory.swift
//  GiftSwap
//
//  Created by Handerson COQ on 2/1/25.
//

import Foundation

struct GiftPurchaseHistory: Identifiable, Codable {
    var id: UUID
    var buyerId: UUID
    var recipientId: UUID?
    var occasion: String?
    var giftId: UUID
    var purchasedAt: Date
    var storeLink: String?
    var priceAtPurchase: Double?
    
    init(
        id: UUID = UUID(),
        buyerId: UUID,
        recipientId: UUID? = nil,
        occasion: String? = nil,
        giftId: UUID,
        purchasedAt: Date = Date(),
        storeLink: String? = nil,
        priceAtPurchase: Double? = nil
    ) {
        self.id = id
        self.buyerId = buyerId
        self.recipientId = recipientId
        self.occasion = occasion
        self.giftId = giftId
        self.purchasedAt = purchasedAt
        self.storeLink = storeLink
        self.priceAtPurchase = priceAtPurchase
    }
}

