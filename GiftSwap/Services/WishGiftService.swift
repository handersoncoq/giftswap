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
    
    // Fetch wishlist gifts with optional filters
    func fetchWishGifts(category: String? = nil, minPrice: Double? = nil, maxPrice: Double? = nil, brand: String? = nil, occasion: String? = nil) -> AnyPublisher<[WishGift], Error> {
        var filteredGifts = wishlist
        
        if let category = category {
            filteredGifts = filteredGifts.filter { $0.category.rawValue == category }
        }
        
        if let minPrice = minPrice {
            filteredGifts = filteredGifts.filter { ($0.price ?? 0) >= minPrice }
        }
        
        if let maxPrice = maxPrice {
            filteredGifts = filteredGifts.filter { ($0.price ?? 0) <= maxPrice }
        }
        
        if let brand = brand {
            filteredGifts = filteredGifts.filter { $0.brand?.lowercased() == brand.lowercased() }
        }
        
        if let occasion = occasion {
            filteredGifts = filteredGifts.filter { $0.occasion.rawValue == occasion }
        }
        
        return Just(filteredGifts)
            .delay(for: .seconds(1), scheduler: RunLoop.main)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    // Add a new wish gift (mock persistence)
    func addWishGift(_ gift: WishGift) -> AnyPublisher<WishGift, Error> {
        wishlist.append(gift)
        
        return Just(gift)
            .delay(for: .seconds(1), scheduler: RunLoop.main)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
    
    // Update a wish gift (mock persistence)
    func updateWishGift(_ updatedGift: WishGift) -> AnyPublisher<WishGift, Error> {
        if let index = wishlist.firstIndex(where: { $0.id == updatedGift.id }) {
            wishlist[index] = updatedGift
            return Just(updatedGift)
                .delay(for: .seconds(1), scheduler: RunLoop.main)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } else {
            return Fail(error: NSError(domain: "WishGiftService", code: 404, userInfo: [NSLocalizedDescriptionKey: "Gift not found"]))
                .eraseToAnyPublisher()
        }
    }
    
    // Delete a wish gift (mock persistence)
    func deleteWishGift(id: UUID) -> AnyPublisher<Bool, Error> {
        if let index = wishlist.firstIndex(where: { $0.id == id }) {
            wishlist.remove(at: index)
            return Just(true)
                .delay(for: .seconds(1), scheduler: RunLoop.main)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } else {
            return Fail(error: NSError(domain: "WishGiftService", code: 404, userInfo: [NSLocalizedDescriptionKey: "Gift not found"]))
                .eraseToAnyPublisher()
        }
    }
    
    func fetchProductDetails(from link: String) -> AnyPublisher<WishGift?, Error> {
        let cleanedLink = cleanStoreURL(link)

        guard let url = URL(string: cleanedLink) else {
            return Fail(error: NSError(domain: "WishGiftService", code: 400, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"]))
                .eraseToAnyPublisher()
        }

        return URLSession.shared.dataTaskPublisher(for: url)
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

                // Extract multiple image URLs manually
                let imageElements = try doc.select("#landingImage, .product-image, img")
                var imageUrls: [String] = []
                for element in imageElements {
                    let src = try? element.attr("src")
                    if let validUrl = src, validUrl.hasPrefix("http") {
                        imageUrls.append(validUrl)
                    }
                    if imageUrls.count >= 4 { break } // Limit to 4 images
                }

                // If no multiple images found, check for a single image URL
                if imageUrls.isEmpty, let singleImageUrl = try? doc.select("#landingImage, .product-image, img").attr("src"), singleImageUrl.hasPrefix("http") {
                    imageUrls.append(singleImageUrl)
                }

                return WishGift(
                    name: name,
                    description: description ?? "No description is provided",
                    category: .other,
                    images: imageUrls, // Always ensures an array
                    storeLink: cleanedLink,
                    price: price,
                    currency: "USD",
                    brand: nil,
                    occasion: .other
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
