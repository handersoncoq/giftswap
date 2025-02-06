//
//  UserRatingService.swift
//  GiftSwap
//
//  Created by Handerson COQ on 2/1/25.
//

import Foundation
import Combine

import Foundation
import Combine

class UserRatingService {
    static let shared = UserRatingService()
    private init() {}

    // Use mock data for now
    private var userRatings: [UserRating] = MockUserRatings.ratings

    // Fetch all ratings for a specific user
    func fetchRatings(forUserId userId: UUID) -> AnyPublisher<[UserRating], Error> {
        let userRatingsList = userRatings.filter { $0.ratedUserId == userId }

        return Just(userRatingsList)
            .delay(for: .seconds(1), scheduler: RunLoop.main)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    // Calculate average rating for a user
    func fetchAverageRating(forUserId userId: UUID) -> AnyPublisher<Double, Error> {
        let userRatingsList = userRatings.filter { $0.ratedUserId == userId }
        let averageRating = userRatingsList.isEmpty ? 5.0 : userRatingsList.map { $0.rating }.reduce(0, +) / Double(userRatingsList.count)

        return Just(averageRating)
            .delay(for: .seconds(1), scheduler: RunLoop.main)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    // Add a user rating (mock persistence)
    func addUserRating(_ rating: UserRating) -> AnyPublisher<UserRating, Error> {
        userRatings.append(rating)

        return Just(rating)
            .delay(for: .seconds(1), scheduler: RunLoop.main)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    // Update user rating (mock persistence)
    func updateUserRating(_ updatedRating: UserRating) -> AnyPublisher<UserRating, Error> {
        if let index = userRatings.firstIndex(where: { $0.id == updatedRating.id }) {
            userRatings[index] = updatedRating
            return Just(updatedRating)
                .delay(for: .seconds(1), scheduler: RunLoop.main)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } else {
            return Fail(error: NSError(domain: "UserRatingService", code: 404, userInfo: [NSLocalizedDescriptionKey: "User rating not found"]))
                .eraseToAnyPublisher()
        }
    }

    // Delete user rating (mock persistence)
    func deleteUserRating(id: UUID) -> AnyPublisher<Bool, Error> {
        if let index = userRatings.firstIndex(where: { $0.id == id }) {
            userRatings.remove(at: index)
            return Just(true)
                .delay(for: .seconds(1), scheduler: RunLoop.main)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } else {
            return Fail(error: NSError(domain: "UserRatingService", code: 404, userInfo: [NSLocalizedDescriptionKey: "User rating not found"]))
                .eraseToAnyPublisher()
        }
    }
}

