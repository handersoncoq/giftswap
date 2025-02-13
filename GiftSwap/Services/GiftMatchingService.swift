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

    // Finds a match for a given gift in the swap basket
    func findMatch(for gift: SwapGift, userId: UUID) -> AnyPublisher<(SwapGift, SwapGift)?, Error> {
        return SwapGiftService.shared.fetchGifts(isAvailable: true)
            .map { swapGifts in
                // Ensure we do not match the user's own swap gifts
                let availableGifts = swapGifts.filter { $0.ownerId != userId }
                return self.findMatchingGift(gift: gift, swapGifts: availableGifts)
            }
            .eraseToAnyPublisher()
    }

    // Finds a matching gift based on multiple criteria
    private func findMatchingGift(gift: SwapGift, swapGifts: [SwapGift]) -> (SwapGift, SwapGift)? {
        // 1️⃣ Exact Name Match
        if let match = swapGifts.first(where: { $0.name.lowercased() == gift.name.lowercased() }) {
            return (gift, match)
        }

        // 2️⃣ Description Similarity Match
        if let match = swapGifts.first(where: { self.isDescriptionSimilar(gift.description, $0.description) }) {
            return (gift, match)
        }

        // 3️⃣ Category-Based Match
        if let match = swapGifts.first(where: { $0.category == gift.category }) {
            return (gift, match)
        }

        // 4️⃣ Value-Based Match (Within 20% Price Range)
        if let match = swapGifts.first(where: {
            abs($0.value - gift.value) / gift.value <= 0.2
        }) {
            return (gift, match)
        }

        return nil // No match found
    }

    // Basic text similarity check (Temporary - Will Be Replaced by AI)
    private func isDescriptionSimilar(_ desc1: String, _ desc2: String) -> Bool {
        let words1 = Set(desc1.lowercased().split(separator: " "))
        let words2 = Set(desc2.lowercased().split(separator: " "))
        let commonWords = words1.intersection(words2)
        return commonWords.count >= 3 // Match if at least 3 words overlap
    }
    
    // Start the matching process for a user
    func startMatchingProcess(for userId: UUID) -> AnyPublisher<(SwapGift, SwapGift)?, Error> {
        return SwapBasketService.shared.fetchUserSwapBasketGifts(userId: userId)
            .flatMap { userSwapGifts in
                guard let userGift = userSwapGifts.first else {
                    return Just<(SwapGift, SwapGift)?>(nil)
                        .setFailureType(to: Error.self)
                        .eraseToAnyPublisher()
                }
                return self.findMatch(for: userGift, userId: userId)
            }
            .eraseToAnyPublisher()
    }
}

