//
//  UserRating.swift
//  GiftSwap
//
//  Created by Handerson COQ on 2/1/25.
//

import Foundation

struct UserRating: Identifiable, Codable {
    var id: UUID
    var raterId: UUID
    var ratedUserId: UUID
    var rating: Double
    var feedback: String?
    var createdAt: Date

    init(
        id: UUID = UUID(),
        raterId: UUID,
        ratedUserId: UUID,
        rating: Double,
        feedback: String? = nil,
        createdAt: Date = Date()
    ) {
        self.id = id
        self.raterId = raterId
        self.ratedUserId = ratedUserId
        self.rating = rating
        self.feedback = feedback
        self.createdAt = createdAt
    }
}
