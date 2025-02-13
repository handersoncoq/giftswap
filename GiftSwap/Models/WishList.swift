//
//  WishList.swift
//  GiftSwap
//
//  Created by Handerson COQ on 2/1/25.
//

import Foundation

struct Wishlist: Identifiable, Codable {
    var id: UUID
    var userId: UUID
    var name: String
    var description: String?
    var isPrivate: Bool
    var isActive: Bool
    var category: WishlistCategory
    var wishGifts: [WishGift]?
    var addedAt: Date
    
    init(
        id: UUID = UUID(),
        userId: UUID,
        name: String,
        description: String? = nil,
        isPrivate: Bool = false,
        isActive: Bool = true,
        category: WishlistCategory = .other,
        wishGifts: [WishGift]? = nil,
        addedAt: Date = Date()
    ) {
        self.id = id
        self.userId = userId
        self.name = name
        self.description = description
        self.isPrivate = isPrivate
        self.isActive = isActive
        self.category = category
        self.wishGifts = wishGifts
        self.addedAt = addedAt
    }
}


