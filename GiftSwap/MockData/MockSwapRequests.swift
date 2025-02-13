//
//  MockSwapRequests.swift
//  GiftSwap
//
//  Created by Handerson COQ on 2/1/25.
//

import Foundation

struct MockSwapRequests {
    static var swapRequests: [SwapRequest] = [
        SwapRequest(
            senderId: MockUsers.users[0].id,
            receiverId: MockUsers.users[1].id,
            senderGiftId: MockSwapGifts.gifts[0].id,
            receiverGiftId: MockSwapGifts.gifts[1].id,
            status: .pending,
            createdAt: Date()
        ),
        SwapRequest(
            senderId: MockUsers.users[2].id,
            receiverId: MockUsers.users[3].id,
            senderGiftId: MockSwapGifts.gifts[2].id,
            receiverGiftId: MockSwapGifts.gifts[3].id,
            status: .accepted,
            createdAt: Date(),
            resolvedAt: Date()
        ),
        SwapRequest(
            senderId: MockUsers.users[4].id,
            receiverId: MockUsers.users[0].id,
            senderGiftId: MockSwapGifts.gifts[4].id,
            receiverGiftId: MockSwapGifts.gifts[0].id,
            status: .declined,
            createdAt: Date(),
            resolvedAt: Date()
        )
    ]
}
