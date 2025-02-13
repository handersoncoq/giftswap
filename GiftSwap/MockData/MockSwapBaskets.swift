//
//  MockSwapBaskets.swift
//  GiftSwap
//
//  Created by Handerson COQ on 2/1/25.
//

import Foundation

struct MockSwapBaskets {
    static var swapBaskets: [SwapBasket] = MockSwapGifts.gifts.map { gift in
        SwapBasket(userId: gift.ownerId, giftId: gift.id, status: .available)
    }
}

