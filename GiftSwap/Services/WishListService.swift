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
    private var wishlists: [Wishlist] = MockWishlists.initializedWishlists

    // Fetch all wishlists
    func fetchAllWishlists() -> AnyPublisher<[Wishlist], Error> {
        return Just(wishlists)
            .delay(for: .seconds(1), scheduler: RunLoop.main)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    // Fetch wishlists for a specific user
    func fetchWishlists(forUserId userId: UUID) -> AnyPublisher<[Wishlist], Error> {
        
        let userWishlists = MockWishlists.mutableWishlists.filter { wishlist in
            return wishlist.userId == userId
        }
        
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

    // Add a wishlist
    func addWishlist(_ wishlist: Wishlist) -> AnyPublisher<Wishlist, Error> {
        wishlists.append(wishlist)
        MockWishlists.mutableWishlists.append(wishlist)
        MockWishlists.refresh()
        return Just(wishlist)
            .delay(for: .seconds(1), scheduler: RunLoop.main)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    // Update a wishlist
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

    // Delete a wishlist
    func deleteWishlist(id: UUID) -> AnyPublisher<Bool, Error> {
        // Remove from in-memory `wishlists`
        if let index = wishlists.firstIndex(where: { $0.id == id }) {
            wishlists.remove(at: index)
        }
        
        // Remove from `MockWishlists.mutableWishlists`
        if let mockIndex = MockWishlists.mutableWishlists.firstIndex(where: { $0.id == id }) {
            MockWishlists.mutableWishlists.remove(at: mockIndex)
        } else {
            return Fail(error: NSError(domain: "WishlistService", code: 404, userInfo: [NSLocalizedDescriptionKey: "Wishlist not found"]))
                .eraseToAnyPublisher()
        }

        return Just(true)
            .delay(for: .seconds(1), scheduler: RunLoop.main)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }


    
    // Fetch a specific wishlist
    func fetchWishlist(id: UUID) -> AnyPublisher<Wishlist?, Error> {
        let wishlist = wishlists.first { $0.id == id }
        return Just(wishlist)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    // Fetch all categories with associated wishlists
    func fetchWishlistsGroupedByCategory() -> AnyPublisher<[WishlistCategory: [Wishlist]], Error> {
        let groupedWishlists = Dictionary(grouping: wishlists, by: { $0.category })
        return Just(groupedWishlists)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}

