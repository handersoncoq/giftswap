//
//  MockUserRatings.swift
//  GiftSwap
//
//  Created by Handerson COQ on 2/1/25.
//

import Foundation

struct MockUserRatings {
    static let ratings: [UserRating] = [
        UserRating(
            raterId: MockUsers.users[1].id,
            ratedUserId: MockUsers.users[0].id,
            rating: 4.8,
            feedback: "Great swap experience! Very smooth transaction.",
            createdAt: Date().addingTimeInterval(-86400 * 5) // 5 days ago
        ),
        UserRating(
            raterId: MockUsers.users[2].id,
            ratedUserId: MockUsers.users[0].id,
            rating: 4.5,
            feedback: "Item was as described. Would swap again.",
            createdAt: Date().addingTimeInterval(-86400 * 10) // 10 days ago
        ),
        UserRating(
            raterId: MockUsers.users[0].id,
            ratedUserId: MockUsers.users[1].id,
            rating: 5.0,
            feedback: "Very friendly and responsive. Highly recommended!",
            createdAt: Date().addingTimeInterval(-86400 * 2) // 2 days ago
        ),
        UserRating(
            raterId: MockUsers.users[3].id,
            ratedUserId: MockUsers.users[2].id,
            rating: 4.2,
            feedback: "Good swap, but took some time to finalize.",
            createdAt: Date().addingTimeInterval(-86400 * 20) // 20 days ago
        ),
        UserRating(
            raterId: MockUsers.users[4].id,
            ratedUserId: MockUsers.users[3].id,
            rating: 4.9,
            feedback: "Very professional and communicative.",
            createdAt: Date().addingTimeInterval(-86400 * 7) // 7 days ago
        ),
        UserRating(
            raterId: MockUsers.users[1].id,
            ratedUserId: MockUsers.users[4].id,
            rating: 5.0,
            feedback: "Item was in perfect condition. Would swap again!",
            createdAt: Date().addingTimeInterval(-86400 * 3) // 3 days ago
        )
    ]
}
