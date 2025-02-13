//
//  MockWishGifts.swift
//  GiftSwap
//
//  Created by Handerson COQ on 2/12/25.
//

import Foundation

struct MockWishGifts {
    static var wishGifts: [WishGift] = [
        WishGift(
            id: UUID(),
            name: "Luxury Watch",
            description: "A stylish luxury watch for any occasion.",
            category: .fashion,
            images: ["https://picsum.photos/300/200", "https://picsum.photos/300/200"],
            storeLink: "https://www.example.com/luxurywatch",
            price: 1500.00,
            currency: "USD",
            brand: "Rolex",
            addedDate: Date(),
            wishListId: MockWishlists.mutableWishlists[0].id
        ),
        WishGift(
            id: UUID(),
            name: "Smartphone Upgrade",
            description: "The latest smartphone model with amazing features.",
            category: .electronics,
            images: ["https://picsum.photos/300/200", "https://picsum.photos/300/200"],
            storeLink: "https://www.example.com/smartphone",
            price: 999.99,
            currency: "USD",
            brand: "Apple",
            addedDate: Date(),
            wishListId: MockWishlists.mutableWishlists[0].id
        ),
        
        WishGift(
            id: UUID(),
            name: "Designer Handbag",
            description: "A high-quality designer leather handbag.",
            category: .fashion,
            images: ["https://picsum.photos/300/200", "https://picsum.photos/300/200"],
            storeLink: "https://www.example.com/handbag",
            price: 250.00,
            currency: "USD",
            brand: "Gucci",
            addedDate: Date(),
            wishListId: MockWishlists.mutableWishlists[1].id
        ),
        WishGift(
            id: UUID(),
            name: "Scented Candle Set",
            description: "Luxury scented candles for relaxation.",
            category: .home,
            images: ["https://picsum.photos/300/200", "https://picsum.photos/300/200"],
            storeLink: "https://www.example.com/candles",
            price: 49.99,
            currency: "USD",
            brand: "Yankee Candle",
            addedDate: Date(),
            wishListId: MockWishlists.mutableWishlists[1].id
        ),
        
        WishGift(
            id: UUID(),
            name: "Laptop for Work & Study",
            description: "A high-performance laptop for productivity and gaming.",
            category: .electronics,
            images: ["https://picsum.photos/300/200", "https://picsum.photos/300/200"],
            storeLink: "https://www.example.com/laptop",
            price: 1299.99,
            currency: "USD",
            brand: "Dell",
            addedDate: Date(),
            wishListId: MockWishlists.mutableWishlists[2].id
        ),
        WishGift(
            id: UUID(),
            name: "Leather Messenger Bag",
            description: "A stylish leather bag for carrying essentials.",
            category: .fashion,
            images: ["https://picsum.photos/300/200", "https://picsum.photos/300/200"],
            storeLink: "https://www.example.com/messengerbag",
            price: 150.00,
            currency: "USD",
            brand: "Coach",
            addedDate: Date(),
            wishListId: MockWishlists.mutableWishlists[2].id
        ),
        
        WishGift(
            id: UUID(),
            name: "Luxury Perfume",
            description: "A premium perfume with a floral scent.",
            category: .beauty,
            images: ["https://picsum.photos/300/200", "https://picsum.photos/300/200"],
            storeLink: "https://www.example.com/perfume",
            price: 120.00,
            currency: "USD",
            brand: "Dior",
            addedDate: Date(),
            wishListId: MockWishlists.mutableWishlists[3].id
        ),
        WishGift(
            id: UUID(),
            name: "Romantic Getaway Package",
            description: "A special getaway experience for two.",
            category: .other,
            images: ["https://picsum.photos/300/200", "https://picsum.photos/300/200"],
            storeLink: "https://www.example.com/getaway",
            price: 899.99,
            currency: "USD",
            brand: "Airbnb",
            addedDate: Date(),
            wishListId: MockWishlists.mutableWishlists[3].id
        ),
        
        WishGift(
            id: UUID(),
            name: "Smart Home Assistant",
            description: "A voice-controlled smart assistant for home automation.",
            category: .home,
            images: ["https://picsum.photos/300/200", "https://picsum.photos/300/200"],
            storeLink: "https://www.example.com/smarthome",
            price: 149.99,
            currency: "USD",
            brand: "Google",
            addedDate: Date(),
            wishListId: MockWishlists.mutableWishlists[4].id
        ),
        WishGift(
            id: UUID(),
            name: "Minimalist Furniture Set",
            description: "A modern minimalist furniture set for a cozy home.",
            category: .home,
            images: ["https://picsum.photos/300/200", "https://picsum.photos/300/200"],
            storeLink: "https://www.example.com/furniture",
            price: 999.99,
            currency: "USD",
            brand: "IKEA",
            addedDate: Date(),
            wishListId: MockWishlists.mutableWishlists[4].id
        ),
        
        // 👶 Isabella Wright's Baby Shower Wishlist Gifts
        WishGift(
            id: UUID(),
            name: "Newborn Essentials Set",
            description: "A collection of must-have baby essentials.",
            category: .other,
            images: ["https://picsum.photos/300/200", "https://picsum.photos/300/200"],
            storeLink: "https://www.example.com/babyessentials",
            price: 129.99,
            currency: "USD",
            brand: "Pampers",
            addedDate: Date(),
            wishListId: MockWishlists.mutableWishlists[5].id
        ),
        WishGift(
            id: UUID(),
            name: "Convertible Baby Crib",
            description: "A high-quality crib that grows with the baby.",
            category: .other,
            images: ["https://picsum.photos/300/200", "https://picsum.photos/300/200"],
            storeLink: "https://www.example.com/babycrib",
            price: 499.99,
            currency: "USD",
            brand: "Graco",
            addedDate: Date(),
            wishListId: MockWishlists.mutableWishlists[5].id
        ),
        WishGift(
            id: UUID(),
            name: "High-Performance Gaming Mouse",
            description: "A professional-grade gaming mouse with customizable buttons.",
            category: .electronics,
            images: ["https://picsum.photos/300/200", "https://picsum.photos/300/200"],
            storeLink: "https://www.example.com/gamingmouse",
            price: 79.99,
            currency: "USD",
            brand: "Razer",
            addedDate: Date(),
            wishListId: MockWishlists.mutableWishlists[6].id
        ),
        WishGift(
            id: UUID(),
            name: "Mechanical Gaming Keyboard",
            description: "RGB-backlit mechanical keyboard with customizable keys.",
            category: .electronics,
            images: ["https://picsum.photos/300/200", "https://picsum.photos/300/200"],
            storeLink: "https://www.example.com/mechanicalkeyboard",
            price: 129.99,
            currency: "USD",
            brand: "Corsair",
            addedDate: Date(),
            wishListId: MockWishlists.mutableWishlists[6].id
        ),
        
        // 📚 Olivia Taylor - Book Lover’s Wishlist
        WishGift(
            id: UUID(),
            name: "Classic Literature Collection",
            description: "A set of beautifully bound classic literature books.",
            category: .books,
            images: ["https://picsum.photos/300/200", "https://picsum.photos/300/200"],
            storeLink: "https://www.example.com/classicbooks",
            price: 199.99,
            currency: "USD",
            brand: "Penguin Classics",
            addedDate: Date(),
            wishListId: MockWishlists.mutableWishlists[7].id
        ),
        WishGift(
            id: UUID(),
            name: "Personalized Leather Journal",
            description: "Handcrafted leather journal with initials engraving.",
            category: .books,
            images: ["https://picsum.photos/300/200", "https://picsum.photos/300/200"],
            storeLink: "https://www.example.com/leatherjournal",
            price: 45.00,
            currency: "USD",
            brand: "Moleskine",
            addedDate: Date(),
            wishListId: MockWishlists.mutableWishlists[7].id
        ),
        
        // 🏡 Noah Walker - Smart Home Wishlist
        WishGift(
            id: UUID(),
            name: "Smart LED Light Bulbs",
            description: "WiFi-enabled LED bulbs with voice control.",
            category: .home,
            images: ["https://picsum.photos/300/200", "https://picsum.photos/300/200"],
            storeLink: "https://www.example.com/smartbulbs",
            price: 59.99,
            currency: "USD",
            brand: "Philips Hue",
            addedDate: Date(),
            wishListId: MockWishlists.mutableWishlists[8].id
        ),
        WishGift(
            id: UUID(),
            name: "Smart Thermostat",
            description: "A smart thermostat with auto-scheduling and energy saving.",
            category: .home,
            images: ["https://picsum.photos/300/200", "https://picsum.photos/300/200"],
            storeLink: "https://www.example.com/smartthermostat",
            price: 249.99,
            currency: "USD",
            brand: "Nest",
            addedDate: Date(),
            wishListId: MockWishlists.mutableWishlists[8].id
        ),
        
        // 🎁 Ava Robinson - Anniversary & Fashion Wishlist
        WishGift(
            id: UUID(),
            name: "Luxury Silk Scarf",
            description: "An elegant silk scarf for a timeless look.",
            category: .fashion,
            images: ["https://picsum.photos/300/200", "https://picsum.photos/300/200"],
            storeLink: "https://www.example.com/silkscarf",
            price: 150.00,
            currency: "USD",
            brand: "Hermès",
            addedDate: Date(),
            wishListId: MockWishlists.mutableWishlists[9].id
        ),
        WishGift(
            id: UUID(),
            name: "Couple's Spa Experience",
            description: "A relaxing spa day for two.",
            category: .other,
            images: ["https://picsum.photos/300/200", "https://picsum.photos/300/200"],
            storeLink: "https://www.example.com/spaexperience",
            price: 299.99,
            currency: "USD",
            brand: "Luxury Spa & Wellness",
            addedDate: Date(),
            wishListId: MockWishlists.mutableWishlists[9].id
        )
    ]
}
