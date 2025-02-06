//
//  WishListService.swift
//  GiftSwap
//
//  Created by Handerson COQ on 2/1/25.
//

import Foundation
import Combine

class WishlistService {
    static let shared = WishlistService()
    private init() {}

    // Mock data for now
    private var wishlists: [Wishlist] = MockWishlists.wishlists

    // Fetch all wishlists
    func fetchWishlists() -> AnyPublisher<[Wishlist], Error> {
        return Just(wishlists)
            .delay(for: .seconds(1), scheduler: RunLoop.main)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    // Fetch wishlists for a specific user
    func fetchWishlists(forUserId userId: UUID) -> AnyPublisher<[Wishlist], Error> {
        let userWishlists = wishlists.filter { $0.userId == userId }

        return Just(userWishlists)
            .delay(for: .seconds(1), scheduler: RunLoop.main)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    // Fetch wishlists by category
    func fetchWishlists(byCategory category: WishlistCategory) -> AnyPublisher<[Wishlist], Error> {
        let filteredWishlists = wishlists.filter { $0.category == category }

        return Just(filteredWishlists)
            .delay(for: .seconds(1), scheduler: RunLoop.main)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    // Add a wishlist (mock persistence)
    func addWishlist(_ wishlist: Wishlist) -> AnyPublisher<Wishlist, Error> {
        wishlists.append(wishlist)

        return Just(wishlist)
            .delay(for: .seconds(1), scheduler: RunLoop.main)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    // Update a wishlist (mock persistence)
    func updateWishlist(_ updatedWishlist: Wishlist) -> AnyPublisher<Wishlist, Error> {
        if let index = wishlists.firstIndex(where: { $0.id == updatedWishlist.id }) {
            wishlists[index] = updatedWishlist
            return Just(updatedWishlist)
                .delay(for: .seconds(1), scheduler: RunLoop.main)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } else {
            return Fail(error: NSError(domain: "WishlistService", code: 404, userInfo: [NSLocalizedDescriptionKey: "Wishlist not found"]))
                .eraseToAnyPublisher()
        }
    }

    // Delete a wishlist (mock persistence)
    func deleteWishlist(id: UUID) -> AnyPublisher<Bool, Error> {
        if let index = wishlists.firstIndex(where: { $0.id == id }) {
            wishlists.remove(at: index)
            return Just(true)
                .delay(for: .seconds(1), scheduler: RunLoop.main)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } else {
            return Fail(error: NSError(domain: "WishlistService", code: 404, userInfo: [NSLocalizedDescriptionKey: "Wishlist not found"]))
                .eraseToAnyPublisher()
        }
    }
}
