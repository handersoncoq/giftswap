//
//  WishGiftService.swift
//  GiftSwap
//
//  Created by Handerson COQ on 2/10/25.
//

import Foundation
import Combine
import SwiftSoup

class WishGiftService {
    static let shared = WishGiftService()
    private init() {}
    
    // Mock data for now
    private var wishlist: [WishGift] = []
    
    
    // Fetch wish gifts for a specific wishlist
    func fetchWishGifts(for wishlistId: UUID) -> AnyPublisher<[WishGift], Error> {
        let filteredGifts = MockWishGifts.wishGifts.filter { $0.wishListId == wishlistId } 
        
        return Just(filteredGifts)
            .delay(for: .seconds(1), scheduler: RunLoop.main)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    
    // Add a new wish gift (mock persistence)
    func addWishGift(_ gift: WishGift) -> AnyPublisher<WishGift, Error> {
        // Append to MockWishGifts
        MockWishGifts.wishGifts.append(gift)

        // Find the corresponding wishlist and add the gift
        if let index = MockWishlists.mutableWishlists.firstIndex(where: { $0.id == gift.wishListId }) {
            MockWishlists.mutableWishlists[index].wishGifts?.append(gift)
        } else {
            return Fail(error: NSError(domain: "WishGiftService", code: 404, userInfo: [NSLocalizedDescriptionKey: "Wishlist not found"]))
                .eraseToAnyPublisher()
        }
        
        MockWishlists.refresh()
        
        return Just(gift)
            .delay(for: .seconds(1), scheduler: RunLoop.main)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }


    
    // Update a wish gift (mock persistence)
    func updateWishGift(_ updatedGift: WishGift) -> AnyPublisher<WishGift, Error> {
        // Update the wish gift inside MockWishGifts
        if let index = MockWishGifts.wishGifts.firstIndex(where: { $0.id == updatedGift.id }) {
            MockWishGifts.wishGifts[index] = updatedGift
        } else {
            return Fail(error: NSError(domain: "WishGiftService", code: 404,
                                       userInfo: [NSLocalizedDescriptionKey: "Gift not found"]))
                .eraseToAnyPublisher()
        }

        // Find the wishlist containing this wish gift and update it
        if let wishlistIndex = MockWishlists.mutableWishlists.firstIndex(where: { $0.id == updatedGift.wishListId }) {
            var wishlist = MockWishlists.mutableWishlists[wishlistIndex] // Create a mutable copy

            if let giftIndex = wishlist.wishGifts?.firstIndex(where: { $0.id == updatedGift.id }) {
                wishlist.wishGifts?[giftIndex] = updatedGift // Update the wish gift
                MockWishlists.mutableWishlists[wishlistIndex] = wishlist // Assign back the updated wishlist
            }
        }
        
        MockWishlists.refresh()

        return Just(updatedGift)
            .delay(for: .seconds(1), scheduler: RunLoop.main)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    
    // Delete a wish gift (mock persistence)
    func deleteWishGift(id: UUID) -> AnyPublisher<Bool, Error> {
        // Remove from MockWishGifts
        if let index = MockWishGifts.wishGifts.firstIndex(where: { $0.id == id }) {
            MockWishGifts.wishGifts.remove(at: index)
        } else {
            return Fail(error: NSError(domain: "WishGiftService", code: 404,
                                       userInfo: [NSLocalizedDescriptionKey: "Gift not found"]))
                .eraseToAnyPublisher()
        }

        // Remove from the associated wishlist
        for i in MockWishlists.mutableWishlists.indices {
            if let giftIndex = MockWishlists.mutableWishlists[i].wishGifts?.firstIndex(where: { $0.id == id }) {
                MockWishlists.mutableWishlists[i].wishGifts?.remove(at: giftIndex)
                break // Exit loop after removal
            }
        }
        
        MockWishlists.refresh()

        return Just(true)
            .delay(for: .seconds(1), scheduler: RunLoop.main)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    func fetchProductDetails(from link: String) -> AnyPublisher<WishGift?, Error> {
        let cleanedLink = cleanStoreURL(link)

        guard let url = URL(string: cleanedLink) else {
            return Fail(error: NSError(domain: "WishGiftService", code: 400, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"]))
                .eraseToAnyPublisher()
        }

        return URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background)) // 🔥 Run network task in background
            .map(\.data)
            .tryMap { data -> WishGift? in
                let html = String(data: data, encoding: .utf8) ?? ""
                let doc = try SwiftSoup.parse(html)

                guard let name = try? doc.select("#productTitle, h1, .product-name").text(), !name.isEmpty else {
                    throw NSError(domain: "WishGiftService", code: 404, userInfo: [NSLocalizedDescriptionKey: "Could not extract product details"])
                }

                let rawDescription = try? doc.select("#feature-bullets, .product-description, .description").text()
                let description = self.cleanDescription(rawDescription)

                let priceString = try? doc.select(".a-price .a-offscreen, .price, .product-price").first()?.text().replacingOccurrences(of: "$", with: "")
                let cleanPrice = priceString?.filter("0123456789.".contains) ?? ""
                let price = Double(cleanPrice)

                var imageUrls: [String] = try doc.select("#landingImage, .product-image, img").compactMap { try? $0.attr("src") }
                imageUrls = imageUrls.filter { $0.hasPrefix("http") }.prefix(4).map { $0 } // Ensure HTTP images only, limit to 4

                return WishGift(
                    name: name,
                    description: description ?? "No description provided",
                    category: .other,
                    images: imageUrls.isEmpty ? ["https://picsum.photos/300/200"] : imageUrls,
                    storeLink: cleanedLink,
                    price: price,
                    currency: "USD",
                    brand: nil,
                    addedDate: Date(),
                    wishListId: UUID()
                )
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }


    
    
    func cleanStoreURL(_ url: String) -> String {
        if let amazonMatch = url.range(of: "/dp/[^/]+" , options: .regularExpression) {
            return "https://www.amazon.com" + url[amazonMatch]
        }
        return url.components(separatedBy: "?").first ?? url
    }

    
    func cleanDescription(_ text: String?) -> String? {
        guard let text = text else { return nil }

        let stopPhrases = [
            "See more product details",
            "Click here for more information",
            "Sign up for deals",
            "Read full description"
        ]

        var cleaned = text
        for phrase in stopPhrases {
            if let range = cleaned.range(of: phrase) {
                cleaned.removeSubrange(range.lowerBound..<cleaned.endIndex)
            }
        }

        return cleaned.trimmingCharacters(in: .whitespacesAndNewlines)
    }


}
