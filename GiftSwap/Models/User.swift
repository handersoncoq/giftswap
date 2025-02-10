//
//  User.swift
//  GiftSwap
//
//  Created by Handerson COQ on 2/1/25.
//

import Foundation

struct User: Identifiable, Codable {
    var id: UUID
    var name: String
    var email: String
    var password: String
    var profilePictureURL: String?
    var rating: Double
    var location: String?
    var createdAt: Date
    var updatedAt: Date?
    
    var wishlists: [Wishlist]?
    var swapBasket: [SwapBasket]?
    var purchaseHistory: [GiftPurchaseHistory]?

    init(
        id: UUID = UUID(),
        name: String,
        email: String,
        password: String,
        profilePictureURL: String? = nil,
        rating: Double = 5.0,
        location: String? = nil,
        createdAt: Date = Date(),
        updatedAt: Date? = nil,
        wishlists: [Wishlist]? = nil,
        swapBasket: [SwapBasket]? = nil,
        purchaseHistory: [GiftPurchaseHistory]? = nil
    ) {
        self.id = id
        self.name = name
        self.email = email
        self.profilePictureURL = profilePictureURL
        self.rating = rating
        self.location = location
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.wishlists = wishlists
        self.swapBasket = swapBasket
        self.purchaseHistory = purchaseHistory
        self.password = password
    }
}

