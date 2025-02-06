//
//  SwapRequest.swift
//  GiftSwap
//
//  Created by Handerson COQ on 2/1/25.
//

import Foundation

enum SwapRequestStatus: String, Codable {
    case pending, accepted, declined, completed
}

struct SwapRequest: Identifiable, Codable {
    var id: UUID
    var senderId: UUID
    var receiverId: UUID
    var senderGiftId: UUID
    var receiverGiftId: UUID
    var status: SwapRequestStatus
    var createdAt: Date
    var resolvedAt: Date?
    
    init(
        id: UUID = UUID(),
        senderId: UUID,
        receiverId: UUID,
        senderGiftId: UUID,
        receiverGiftId: UUID,
        status: SwapRequestStatus = .pending,
        createdAt: Date = Date(),
        resolvedAt: Date? = nil
    ) {
        self.id = id
        self.senderId = senderId
        self.receiverId = receiverId
        self.senderGiftId = senderGiftId
        self.receiverGiftId = receiverGiftId
        self.status = status
        self.createdAt = createdAt
        self.resolvedAt = resolvedAt
    }
}
