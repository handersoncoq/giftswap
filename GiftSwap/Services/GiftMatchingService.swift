//
//  GiftMatchingService.swift
//  GiftSwap
//
//  Created by Handerson COQ on 2/9/25.
//

import Foundation
import Combine

class GiftMatchingService {
    static let shared = GiftMatchingService() // Singleton instance
    private init() {}

    private var cancellables = Set<AnyCancellable>()

    /// Finds a match for a given gift in the swap basket
    func findMatch(for gift: Gift, userId: UUID) -> AnyPublisher<Gift?, Error> {
        return Future<Gift?, Error> { promise in
            // Step 1: Fetch ALL wishlists for this user
            WishlistService.shared.fetchWishlists(forUserId: userId)
                .map { wishlists in
                    return wishlists.flatMap { wishlist in
                        // Convert wishlist names into gift lookup
                        MockGifts.gifts.filter { gift in
                            wishlist.name.localizedCaseInsensitiveContains(gift.name) // Mock filtering
                        }
                    }
                }
                .flatMap { wishlistGifts -> AnyPublisher<Gift?, Error> in
                    // Step 2: Fetch all gifts in swap baskets
                    SwapBasketService.shared.fetchAllGiftsInSwapBaskets()
                        .map { swapGifts in
                            return self.findMatchingGift(
                                gift: gift,
                                wishlistGifts: wishlistGifts,
                                swapGifts: swapGifts
                            )
                        }
                        .eraseToAnyPublisher()
                }
                .sink(receiveCompletion: { completion in
                    if case .failure(let error) = completion {
                        promise(.failure(error))
                    }
                }, receiveValue: { matchedGift in
                    promise(.success(matchedGift))
                })
                .store(in: &self.cancellables)
        }
        .eraseToAnyPublisher()
    }

    /// Finds a matching gift based on multiple criteria
    private func findMatchingGift(gift: Gift, wishlistGifts: [Gift], swapGifts: [Gift]) -> Gift? {
        // Exact Name Match
        if let match = wishlistGifts.first(where: { $0.name.lowercased() == gift.name.lowercased() }) {
            return match
        }
        
        // Description Similarity (Basic Text Matching for Now)
        if let match = swapGifts.first(where: { self.isDescriptionSimilar(gift.description, $0.description) }) {
            return match
        }

        // Category-Based Match
        if let match = swapGifts.first(where: { $0.category == gift.category && $0.ownerId != gift.ownerId }) {
            return match
        }

        // Value-Based Match (Within 20% Price Range)**
        if let match = swapGifts.first(where: {
            $0.ownerId != gift.ownerId && abs($0.value - gift.value) / gift.value <= 0.2
        }) {
            return match
        }

        // User Wishlist vs. Other Swap Baskets
        if let match = swapGifts.first(where: { _ in wishlistGifts.contains(where: { $0.name.lowercased() == $0.name.lowercased() }) }) {
            return match
        }


        return nil // No match found
    }

    /// Basic text similarity check (Temporary - Will Be Replaced by AI)
    private func isDescriptionSimilar(_ desc1: String, _ desc2: String) -> Bool {
        let words1 = Set(desc1.lowercased().split(separator: " "))
        let words2 = Set(desc2.lowercased().split(separator: " "))
        let commonWords = words1.intersection(words2)
        return commonWords.count >= 3 // Match if at least 3 words overlap
    }
    
    // Start the process
    func startMatchingProcess(for userId: UUID) -> AnyPublisher<Gift?, Error> {
        return SwapBasketService.shared.fetchAllGiftsInSwapBaskets()
            .flatMap { gifts -> AnyPublisher<Gift?, Error> in
                if let gift = gifts.first(where: { $0.ownerId == userId }) {
                    return self.findMatch(for: gift, userId: userId)
                }
                return Just(nil)
                    .setFailureType(to: Error.self)
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }

}
