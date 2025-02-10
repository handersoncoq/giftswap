//
//  MockGifts.swift
//  GiftSwap
//
//  Created by Handerson COQ on 2/1/25.
//

import Foundation

struct MockGifts {
    static let gifts: [Gift] = [
        Gift(
            name: "Octo Finissimo Watch",
            description: "A sleek and stylish timepiece for any occasion.",
            imageURLs: ["https://picsum.photos/300/200", "https://picsum.photos/300/200"],
            value: 36500.00,
            isAvailable: true,
            storeLink: "https://www.bulgari.com/en-us/watches/mens/octo-finissimo-watch-brown-gold",
            category: .fashion,
            ownerId: MockUsers.users[0].id,
            swapStatus: .available,
            addedAt: Date()
        ),
        Gift(
            name: "Amazon Echo Spot",
            description: "A voice-controlled smart speaker with premium sound quality.",
            imageURLs: ["https://picsum.photos/300/200", "https://picsum.photos/300/200", "https://picsum.photos/300/200"],
            value: 79.99,
            isAvailable: true,
            storeLink: "https://www.amazon.com/dp/B0BFC7WQ6R",
            category: .electronics,
            ownerId: MockUsers.users[1].id,
            swapStatus: .available,
            addedAt: Date()
        ),
        Gift(
            name: "Handmade Leather Wallet",
            description: "A handcrafted genuine leather wallet with multiple compartments.",
            imageURLs: [],
            value: 49.99,
            isAvailable: false,
            storeLink: "https://www.amazon.com/dp/B0BFC7WQ6R",
            category: .fashion,
            ownerId: MockUsers.users[2].id,
            swapStatus: .available,
            addedAt: Date()
        ),
        Gift(
            name: "Aromatic Scented Candles",
            description: "A set of 4 relaxing and long-lasting scented candles.",
            imageURLs: [],
            value: 29.99,
            isAvailable: false,
            storeLink: "https://www.amazon.com/dp/B0BFC7WQ6R",
            category: .home,
            ownerId: MockUsers.users[3].id,
            swapStatus: .available,
            addedAt: Date()
        ),
//        Gift(
//            name: "Personalized Notebook",
//            description: "A custom notebook with an elegant design, perfect for journaling.",
//            imageURLs: ["https://picsum.photos/300/200"],
//            value: 19.99,
//            isAvailable: true,
//            category: .other,
//            ownerId: MockUsers.users[1].id,
//            swapStatus: .available,
//            addedAt: Date()
//        ),
        Gift(
                name: "Wireless Earbuds",
                description: "Noise-cancelling wireless earbuds with 20-hour battery life.",
                imageURLs: ["https://picsum.photos/300/200", "https://picsum.photos/300/200"],
                value: 129.99,
                storeLink: "https://www.amazon.com/dp/B0BFC7WQ6R",
                category: .electronics,
                ownerId: MockUsers.users[4].id,
                swapStatus: .available
            ),
            Gift(
                name: "Leather Jacket",
                description: "Genuine leather jacket, size M.",
                imageURLs: [],
                value: 199.99,
                storeLink: "https://www.amazon.com/dp/B0BFC7WQ6R",
                category: .fashion,
                ownerId: MockUsers.users[3].id,
                swapStatus: .available
            ),
            Gift(
                name: "Coffee Table Book",
                description: "Hardcover book on modern architecture.",
                imageURLs: ["https://picsum.photos/300/200", "https://picsum.photos/300/200"],
                value: 45.00,
                storeLink: "https://www.amazon.com/dp/B0BFC7WQ6R",
                category: .books,
                ownerId: MockUsers.users[2].id,
                swapStatus: .available
            ),
            Gift(
                name: "Smart Thermostat",
                description: "Wi-Fi enabled smart thermostat for home automation.",
                imageURLs: ["https://picsum.photos/300/200", "https://picsum.photos/300/200"],
                value: 149.99,
                storeLink: "https://www.amazon.com/dp/B0BFC7WQ6R",
                category: .home,
                ownerId: MockUsers.users[4].id,
                swapStatus: .available
            ),
            Gift(
                name: "Electric Shaver",
                description: "Cordless electric shaver with precision trimmer.",
                imageURLs: [],
                value: 89.99,
                storeLink: "https://www.amazon.com/dp/B0BFC7WQ6R",
                category: .beauty,
                ownerId: MockUsers.users[3].id,
                swapStatus: .available
            ),
        Gift(
                name: "Robot Vacuum",
                description: "Smart robot vacuum with app control.",
                imageURLs: ["https://picsum.photos/300/200", "https://picsum.photos/300/200"],
                value: 299.99,
                storeLink: "https://www.amazon.com/dp/B0BFC7WQ6R",
                category: .home,
                ownerId: MockUsers.users[0].id,
                swapStatus: .available
            ),
            Gift(
                name: "Bluetooth Speaker",
                description: "Portable Bluetooth speaker with 12-hour battery.",
                imageURLs: [],
                value: 59.99,
                storeLink: "https://www.amazon.com/dp/B0BFC7WQ6R",
                category: .electronics,
                ownerId: MockUsers.users[1].id,
                swapStatus: .available
            ),
            Gift(
                name: "Designer Sunglasses",
                description: "UV-protection designer sunglasses.",
                imageURLs: ["https://picsum.photos/300/200", "https://picsum.photos/300/200"],
                value: 159.99,
                storeLink: "https://www.amazon.com/dp/B0BFC7WQ6R",
                category: .fashion,
                ownerId: MockUsers.users[2].id,
                swapStatus: .available
            ),
            Gift(
                name: "Yoga Mat",
                description: "Eco-friendly yoga mat with carrying strap.",
                imageURLs: ["https://picsum.photos/300/200", "https://picsum.photos/300/200"],
                value: 29.99,
                storeLink: "https://www.amazon.com/dp/B0BFC7WQ6R",
                category: .home,
                ownerId: MockUsers.users[3].id,
                swapStatus: .available
            ),
            Gift(
                name: "Perfume Set",
                description: "Luxury perfume set with 3 fragrances.",
                imageURLs: ["https://picsum.photos/300/200", "https://picsum.photos/300/200"],
                value: 79.99,
                storeLink: "https://www.amazon.com/dp/B0BFC7WQ6R",
                category: .beauty,
                ownerId: MockUsers.users[4].id,
                swapStatus: .available
            ),
//            Gift(
//                name: "Board Game",
//                description: "Family board game for 2-6 players.",
//                imageURLs: ["https://picsum.photos/300/200", "https://picsum.photos/300/200"],
//                value: 39.99,
//                category: .toys,
//                ownerId: MockUsers.users[2].id,
//                swapStatus: .available
//            ),
                Gift(id: UUID(), name: "Designer Handbag", description: "Elegant leather handbag.", imageURLs: nil, value: 250.0, isAvailable: true, storeLink: "https://www.amazon.com/dp/B0BFC7WQ6R", category: .fashion, ownerId: UUID(), swapStatus: .inBasket, addedAt: Date()),
                Gift(id: UUID(), name: "Luxury Sunglasses", description: "Stylish UV-protected sunglasses.", imageURLs: nil, value: 180.0, isAvailable: true, storeLink: "https://www.amazon.com/dp/B0BFC7WQ6R", category: .fashion, ownerId: UUID(), swapStatus: .inBasket, addedAt: Date()),
                Gift(id: UUID(), name: "Leather Boots", description: "Premium leather boots.", imageURLs: nil, value: 320.0, isAvailable: true, storeLink: "https://www.amazon.com/dp/B0BFC7WQ6R", category: .fashion, ownerId: UUID(), swapStatus: .inBasket, addedAt: Date()),
                Gift(id: UUID(), name: "Tailored Suit", description: "Custom-fit stylish suit.", imageURLs: nil, value: 500.0, isAvailable: true, storeLink: "https://www.amazon.com/dp/B0BFC7WQ6R", category: .fashion, ownerId: UUID(), swapStatus: .inBasket, addedAt: Date()),
                Gift(id: UUID(), name: "Luxury Watch", description: "Elegant wristwatch with sapphire glass.", imageURLs: nil, value: 1000.0, isAvailable: true, storeLink: "https://www.amazon.com/dp/B0BFC7WQ6R", category: .fashion, ownerId: UUID(), swapStatus: .inBasket, addedAt: Date()),
                Gift(id: UUID(), name: "Designer Scarf", description: "Silk scarf from a renowned brand.", imageURLs: nil, value: 150.0, isAvailable: true, storeLink: "https://www.amazon.com/dp/B0BFC7WQ6R", category: .fashion, ownerId: UUID(), swapStatus: .inBasket, addedAt: Date()),
                Gift(id: UUID(), name: "High-End Sneakers", description: "Limited edition fashion sneakers.", imageURLs: nil, value: 450.0, isAvailable: true, storeLink: "https://www.amazon.com/dp/B0BFC7WQ6R", category: .fashion, ownerId: UUID(), swapStatus: .inBasket, addedAt: Date()),
                Gift(id: UUID(), name: "Cashmere Sweater", description: "Soft and warm cashmere sweater.", imageURLs: nil, value: 300.0, isAvailable: true, storeLink: "https://www.amazon.com/dp/B0BFC7WQ6R", category: .fashion, ownerId: UUID(), swapStatus: .inBasket, addedAt: Date()),
                Gift(id: UUID(), name: "Luxury Belt", description: "Handmade designer belt.", imageURLs: nil, value: 200.0, isAvailable: true, storeLink: "https://www.amazon.com/dp/B0BFC7WQ6R", category: .fashion, ownerId: UUID(), swapStatus: .inBasket, addedAt: Date()),
                Gift(id: UUID(), name: "Trendy Overcoat", description: "Warm and fashionable overcoat.", imageURLs: nil, value: 600.0, isAvailable: true, storeLink: "https://www.amazon.com/dp/B0BFC7WQ6R", category: .fashion, ownerId: UUID(), swapStatus: .inBasket, addedAt: Date()),
                Gift(id: UUID(), name: "Vintage Hat", description: "Retro-style vintage hat.", imageURLs: nil, value: 120.0, isAvailable: true, storeLink: "https://www.amazon.com/dp/B0BFC7WQ6R", category: .fashion, ownerId: UUID(), swapStatus: .inBasket, addedAt: Date()),
        Gift(id: UUID(), name: "Grandma Recipe Book", description: "Taste best food from my grandma recipes", imageURLs: nil, value: 120.0, isAvailable: true, storeLink: "https://www.amazon.com/dp/B0BFC7WQ6R", category: .books, ownerId: UUID(), swapStatus: .available, addedAt: Date()),
                Gift(id: UUID(), name: "Designer Handbag", description: "Elegant leather handbag.", imageURLs: nil, value: 250.0, isAvailable: true, storeLink: "https://www.amazon.com/dp/B0BFC7WQ6R", category: .fashion, ownerId: UUID(), swapStatus: .available, addedAt: Date()),
                Gift(id: UUID(), name: "Luxury Sunglasses", description: "Stylish UV-protected sunglasses.", imageURLs: nil, value: 180.0, isAvailable: true, storeLink: "https://www.amazon.com/dp/B0BFC7WQ6R", category: .fashion, ownerId: UUID(), swapStatus: .available, addedAt: Date()),
                Gift(id: UUID(), name: "Leather Boots", description: "Premium leather boots.", imageURLs: nil, value: 320.0, isAvailable: true, storeLink: "https://www.amazon.com/dp/B0BFC7WQ6R", category: .fashion, ownerId: UUID(), swapStatus: .available, addedAt: Date()),
                Gift(id: UUID(), name: "Tailored Suit", description: "Custom-fit stylish suit.", imageURLs: nil, value: 500.0, isAvailable: true, storeLink: "https://www.amazon.com/dp/B0BFC7WQ6R", category: .fashion, ownerId: UUID(), swapStatus: .available, addedAt: Date()),
                Gift(id: UUID(), name: "Luxury Watch", description: "Elegant wristwatch with sapphire glass.", imageURLs: nil, value: 1000.0, isAvailable: true, storeLink: "https://www.amazon.com/dp/B0BFC7WQ6R", category: .fashion, ownerId: UUID(), swapStatus: .available, addedAt: Date()),
                Gift(id: UUID(), name: "Designer Scarf", description: "Silk scarf from a renowned brand.", imageURLs: nil, value: 150.0, isAvailable: true, storeLink: "https://www.amazon.com/dp/B0BFC7WQ6R", category: .fashion, ownerId: UUID(), swapStatus: .available, addedAt: Date()),
                Gift(id: UUID(), name: "High-End Sneakers", description: "Limited edition fashion sneakers.", imageURLs: nil, value: 450.0, isAvailable: true, storeLink: "https://www.amazon.com/dp/B0BFC7WQ6R", category: .fashion, ownerId: UUID(), swapStatus: .available, addedAt: Date()),
                Gift(id: UUID(), name: "Cashmere Sweater", description: "Soft and warm cashmere sweater.", imageURLs: nil, value: 300.0, isAvailable: true, storeLink: "https://www.amazon.com/dp/B0BFC7WQ6R", category: .fashion, ownerId: UUID(), swapStatus: .available, addedAt: Date()),
                Gift(id: UUID(), name: "Luxury Belt", description: "Handmade designer belt.", imageURLs: nil, value: 200.0, isAvailable: true, storeLink: "https://www.amazon.com/dp/B0BFC7WQ6R", category: .fashion, ownerId: UUID(), swapStatus: .available, addedAt: Date()),
                Gift(id: UUID(), name: "Trendy Overcoat", description: "Warm and fashionable overcoat.", imageURLs: nil, value: 600.0, isAvailable: true, storeLink: "https://www.amazon.com/dp/B0BFC7WQ6R", category: .fashion, ownerId: UUID(), swapStatus: .available, addedAt: Date()),
                Gift(id: UUID(), name: "Vintage Hat", description: "Retro-style vintage hat.", imageURLs: nil, value: 120.0, isAvailable: true, storeLink: "https://www.amazon.com/dp/B0BFC7WQ6R", category: .fashion, ownerId: UUID(), swapStatus: .available, addedAt: Date()),
                Gift(id: UUID(), name: "Elegant Dress", description: "Perfect evening dress for events.", imageURLs: nil, value: 800.0, isAvailable: true, storeLink: "https://www.amazon.com/dp/B0BFC7WQ6R", category: .fashion, ownerId: UUID(), swapStatus: .available, addedAt: Date())

    ]
}
