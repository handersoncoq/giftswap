//
//  MockGifts.swift
//  GiftSwap
//
//  Created by Handerson COQ on 2/1/25.
//

import Foundation

struct MockSwapGifts {
    static var gifts: [SwapGift] = [
        // Handerson Coq - Fashion & Electronics
        SwapGift(
            name: "Luxury Watch",
            description: "Elegant wristwatch.",
            imageURLs: ["https://picsum.photos/300/200", "https://picsum.photos/300/200", "https://picsum.photos/300/200"],
            value: 1200.00,
            storeLink: "https://www.example.com/watch",
            category: .fashion,
            ownerId: MockUsers.users[0].id,
            swapStatus: .available,
            addedAt: Date()
        ),
        SwapGift(
            name: "Designer Sneakers",
            description: "High-end sneakers.",
            imageURLs: ["https://picsum.photos/300/200", "https://picsum.photos/300/200"],
            value: 250.00,
            storeLink: "https://www.example.com/sneakers",
            category: .fashion,
            ownerId: MockUsers.users[0].id,
            swapStatus: .available,
            addedAt: Date()
        ),
        SwapGift(
            name: "Bluetooth Speaker",
            description: "Portable Bluetooth speaker.",
            imageURLs: ["https://picsum.photos/300/200", "https://picsum.photos/300/200"],
            value: 99.99,
            storeLink: "https://www.example.com/speaker",
            category: .electronics,
            ownerId: MockUsers.users[0].id,
            swapStatus: .available,
            addedAt: Date()
        ),
        SwapGift(
            name: "Smartwatch",
            description: "Advanced smartwatch with health tracking.",
            imageURLs: ["https://picsum.photos/300/200", "https://picsum.photos/300/200", "https://picsum.photos/300/200"],
            value: 350.00,
            storeLink: "https://www.example.com/smartwatch",
            category: .electronics,
            ownerId: MockUsers.users[0].id,
            swapStatus: .available,
            addedAt: Date()
        ),

        // Emma Johnson - Home & Beauty
        SwapGift(
            name: "Scented Candle Set",
            description: "Aromatic candle set for relaxation.",
            imageURLs: ["https://picsum.photos/300/200", "https://picsum.photos/300/200"],
            value: 40.00,
            storeLink: "https://www.example.com/candles",
            category: .home,
            ownerId: MockUsers.users[1].id,
            swapStatus: .available,
            addedAt: Date()
        ),
        SwapGift(
            name: "Smart Thermostat",
            description: "Wi-Fi enabled smart thermostat.",
            imageURLs: ["https://picsum.photos/300/200", "https://picsum.photos/300/200"],
            value: 120.00,
            storeLink: "https://www.example.com/thermostat",
            category: .home,
            ownerId: MockUsers.users[1].id,
            swapStatus: .available,
            addedAt: Date()
        ),
        SwapGift(
            name: "Luxury Perfume",
            description: "Premium fragrance collection.",
            imageURLs: ["https://picsum.photos/300/200", "https://picsum.photos/300/200", "https://picsum.photos/300/200"],
            value: 85.00,
            storeLink: "https://www.example.com/perfume",
            category: .beauty,
            ownerId: MockUsers.users[1].id,
            swapStatus: .available,
            addedAt: Date()
        ),
        SwapGift(
            name: "Skincare Set",
            description: "Complete skincare package.",
            imageURLs: ["https://picsum.photos/300/200", "https://picsum.photos/300/200"],
            value: 75.00,
            storeLink: "https://www.example.com/skincare",
            category: .beauty,
            ownerId: MockUsers.users[1].id,
            swapStatus: .available,
            addedAt: Date()
        ),

        // Michael Carter - Books & Fashion
        SwapGift(
            name: "Art Coffee Table Book",
            description: "A beautiful collection of modern art.",
            imageURLs: ["https://picsum.photos/300/200", "https://picsum.photos/300/200"],
            value: 45.00,
            storeLink: "https://www.example.com/artbook",
            category: .books,
            ownerId: MockUsers.users[2].id,
            swapStatus: .available,
            addedAt: Date()
        ),
        SwapGift(
            name: "Cooking Masterclass Book",
            description: "A book filled with amazing recipes.",
            imageURLs: ["https://picsum.photos/300/200", "https://picsum.photos/300/200"],
            value: 35.00,
            storeLink: "https://www.example.com/cookingbook",
            category: .books,
            ownerId: MockUsers.users[2].id,
            swapStatus: .available,
            addedAt: Date()
        ),
        SwapGift(
            name: "Leather Jacket",
            description: "A stylish real leather jacket.",
            imageURLs: ["https://picsum.photos/300/200", "https://picsum.photos/300/200", "https://picsum.photos/300/200"],
            value: 220.00,
            storeLink: "https://www.example.com/leatherjacket",
            category: .fashion,
            ownerId: MockUsers.users[2].id,
            swapStatus: .available,
            addedAt: Date()
        ),
        SwapGift(
            name: "Designer Sunglasses",
            description: "Luxury sunglasses with UV protection.",
            imageURLs: ["https://picsum.photos/300/200", "https://picsum.photos/300/200"],
            value: 150.00,
            storeLink: "https://www.example.com/sunglasses",
            category: .fashion,
            ownerId: MockUsers.users[2].id,
            swapStatus: .available,
            addedAt: Date()
        ),

        // Sophia Martinez - Beauty & Electronics
        SwapGift(
            name: "Makeup Kit",
            description: "Professional makeup kit.",
            imageURLs: ["https://picsum.photos/300/200", "https://picsum.photos/300/200"],
            value: 90.00,
            storeLink: "https://www.example.com/makeup",
            category: .beauty,
            ownerId: MockUsers.users[3].id,
            swapStatus: .available,
            addedAt: Date()
        ),
        SwapGift(
            name: "Luxury Lipstick Set",
            description: "Set of premium lipsticks.",
            imageURLs: ["https://picsum.photos/300/200", "https://picsum.photos/300/200", "https://picsum.photos/300/200"],
            value: 75.00,
            storeLink: "https://www.example.com/lipstick",
            category: .beauty,
            ownerId: MockUsers.users[3].id,
            swapStatus: .available,
            addedAt: Date()
        ),
        SwapGift(
            name: "Wireless Earbuds",
            description: "High-quality wireless earbuds.",
            imageURLs: ["https://picsum.photos/300/200", "https://picsum.photos/300/200"],
            value: 129.99,
            storeLink: "https://www.example.com/earbuds",
            category: .electronics,
            ownerId: MockUsers.users[3].id,
            swapStatus: .available,
            addedAt: Date()
        ),
        SwapGift(
            name: "Gaming Mouse",
            description: "Ergonomic mouse for gaming.",
            imageURLs: ["https://picsum.photos/300/200", "https://picsum.photos/300/200"],
            value: 89.99,
            storeLink: "https://www.example.com/mouse",
            category: .electronics,
            ownerId: MockUsers.users[3].id,
            swapStatus: .available,
            addedAt: Date()
        ),

        // Liam Brown - Home & Books
        SwapGift(
            name: "Smart Coffee Maker",
            description: "Wi-Fi enabled coffee maker with scheduling.",
            imageURLs: ["https://picsum.photos/300/200", "https://picsum.photos/300/200"],
            value: 199.99,
            storeLink: "https://www.example.com/coffeemaker",
            category: .home,
            ownerId: MockUsers.users[4].id,
            swapStatus: .available,
            addedAt: Date()
        ),
        SwapGift(
            name: "Robot Vacuum",
            description: "Smart robot vacuum with app control.",
            imageURLs: ["https://picsum.photos/300/200", "https://picsum.photos/300/200"],
            value: 299.99,
            storeLink: "https://www.example.com/robotvacuum",
            category: .home,
            ownerId: MockUsers.users[4].id,
            swapStatus: .available,
            addedAt: Date()
        ),
        SwapGift(
            name: "Mystery Novel Collection",
            description: "A set of thrilling mystery novels.",
            imageURLs: ["https://picsum.photos/300/200", "https://picsum.photos/300/200"],
            value: 50.00,
            storeLink: "https://www.example.com/mysterynovels",
            category: .books,
            ownerId: MockUsers.users[4].id,
            swapStatus: .available,
            addedAt: Date()
        ),
        SwapGift(
            name: "Self-Improvement Guide",
            description: "A book on personal development and success.",
            imageURLs: ["https://picsum.photos/300/200", "https://picsum.photos/300/200"],
            value: 35.00,
            storeLink: "https://www.example.com/selfimprovement",
            category: .books,
            ownerId: MockUsers.users[4].id,
            swapStatus: .available,
            addedAt: Date()
        )

    ]
}

