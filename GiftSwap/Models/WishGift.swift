//
//  WishGift.swift
//  GiftSwap
//
//  Created by Handerson COQ on 2/10/25.
//

import Foundation

struct WishGift: Identifiable, Codable {
    let id: UUID
    var name: String
    var description: String
    var category: GiftCategory
    var images: [String]
    var storeLink: String
    var price: Double?
    var currency: String? = "USD"
    var brand: String?
    var addedDate: Date
    var wishListId: UUID?

    init(
        id: UUID = UUID(),
        name: String,
        description: String,
        category: GiftCategory,
        images: [String],
        storeLink: String,
        price: Double? = nil,
        currency: String? = nil,
        brand: String? = nil,
        addedDate: Date = Date(),
        wishListId: UUID
    ) {
        self.id = id
        self.name = name
        self.description = description
        self.category = category
        self.images = images
        self.storeLink = storeLink
        self.price = price
        self.currency = currency
        self.brand = brand
        self.addedDate = addedDate
        self.wishListId = wishListId
    }
}
