//
//  WishList.swift
//  GiftSwap
//
//  Created by Handerson COQ on 2/1/25.
//

import Foundation

enum WishlistCategory: String, Codable {
    case birthday, christmas, wedding, milestone, anniversary, personal, other
}

struct Wishlist: Identifiable, Codable {
    var id: UUID
    var userId: UUID
    var name: String
    var description: String?
    var isPrivate: Bool
    var isActive: Bool
    var category: WishlistCategory
    var addedAt: Date
    
    init(
        id: UUID = UUID(),
        userId: UUID,
        name: String,
        description: String? = nil,
        isPrivate: Bool = false,
        isActive: Bool = true,
        category: WishlistCategory = .other,
        addedAt: Date = Date()
    ) {
        self.id = id
        self.userId = userId
        self.name = name
        self.description = description
        self.isPrivate = isPrivate
        self.isActive = isActive
        self.category = category
        self.addedAt = addedAt
    }
}


