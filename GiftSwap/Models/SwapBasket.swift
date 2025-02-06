//
//  SwapBasket.swift
//  GiftSwap
//
//  Created by Handerson COQ on 2/1/25.
//

import Foundation

struct SwapBasket: Identifiable, Codable {
    var id: UUID
    var userId: UUID
    var giftId: UUID
    var status: SwapStatus
    var addedAt: Date
    
    init(
        id: UUID = UUID(),
        userId: UUID,
        giftId: UUID,
        status: SwapStatus = .available,
        addedAt: Date = Date()
    ) {
        self.id = id
        self.userId = userId
        self.giftId = giftId
        self.status = status
        self.addedAt = addedAt
    }
}
