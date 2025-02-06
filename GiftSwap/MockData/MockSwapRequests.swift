//
//  MockSwapRequests.swift
//  GiftSwap
//
//  Created by Handerson COQ on 2/1/25.
//

import Foundation

struct MockSwapRequests {
    static let swapRequests: [SwapRequest] = [
        SwapRequest(
            senderId: MockUsers.users[0].id,
            receiverId: MockUsers.users[1].id,
            senderGiftId: MockGifts.gifts[0].id,
            receiverGiftId: MockGifts.gifts[1].id,
            status: .pending,
            createdAt: Date()
        ),
        SwapRequest(
            senderId: MockUsers.users[2].id,
            receiverId: MockUsers.users[3].id,
            senderGiftId: MockGifts.gifts[2].id,
            receiverGiftId: MockGifts.gifts[3].id,
            status: .accepted,
            createdAt: Date(),
            resolvedAt: Date()
        ),
        SwapRequest(
            senderId: MockUsers.users[4].id,
            receiverId: MockUsers.users[0].id,
            senderGiftId: MockGifts.gifts[4].id,
            receiverGiftId: MockGifts.gifts[0].id,
            status: .declined,
            createdAt: Date(),
            resolvedAt: Date()
        )
    ]
}
