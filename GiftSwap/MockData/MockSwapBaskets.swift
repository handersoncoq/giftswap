//
//  MockSwapBaskets.swift
//  GiftSwap
//
//  Created by Handerson COQ on 2/1/25.
//

import Foundation

struct MockSwapBaskets {
    static let swapBaskets: [SwapBasket] = MockGifts.gifts.map { gift in
        SwapBasket(userId: UUID(), giftId: gift.id, status: .inBasket)
    }
}
