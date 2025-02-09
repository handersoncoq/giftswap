//
//  Gift.swift
//  GiftSwap
//
//  Created by Handerson COQ on 1/27/25.
//

import Foundation

enum GiftCategory: String, Codable {
    case electronics, fashion, books, home, beauty, toys, other
}

enum SwapStatus: String, Codable {
    case available
    case inBasket
    case matched
    case swapped
    case notListed
    case personalUse
}


struct Gift: Identifiable, Codable {
    var id: UUID
    var name: String
    var description: String
    var imageURLs: [String]?
    var value: Double
    var isAvailable: Bool
    var storeLink: String?
    var category: GiftCategory
    var ownerId: UUID
    var swapStatus: SwapStatus
    var addedAt: Date
    
    init(
        id: UUID = UUID(),
        name: String,
        description: String,
        imageURLs: [String]? = nil,
        value: Double,
        isAvailable: Bool = true,
        storeLink: String? = nil,
        category: GiftCategory,
        ownerId: UUID,
        swapStatus: SwapStatus = .available,
        addedAt: Date = Date()
    ) {
        self.id = id
        self.name = name
        self.description = description
        self.imageURLs = imageURLs
        self.value = value
        self.isAvailable = isAvailable
        self.storeLink = storeLink
        self.category = category
        self.ownerId = ownerId
        self.swapStatus = swapStatus
        self.addedAt = addedAt
    }
}

