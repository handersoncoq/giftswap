//
//  MockWishLists.swift
//  GiftSwap
//
//  Created by Handerson COQ on 2/1/25.
//

import Foundation

struct MockWishlists {
    static var wishlists: [Wishlist] = [
        // Handerson Coq - Birthday & Just Because
        
        Wishlist(
            id: UUID(),
            userId: MockUsers.users[0].id,
            name: "My 25th Birthday",
            description: "Gifts I'd love to receive for my upcoming birthday!",
            isPrivate: false,
            isActive: true,
            category: .birthday,
            addedAt: Date()
        ),
        Wishlist(
            userId: MockUsers.users[0].id,
            name: "Just Because Gifts",
            description: "Surprise gifts I'd love to receive.",
            isPrivate: false,
            isActive: true,
            category: .justBecause,
            addedAt: Date()
        ),

        // 🎄 Emma Johnson - Christmas & Housewarming
        Wishlist(
            userId: MockUsers.users[1].id,
            name: "My Christmas Wishlist",
            description: "My dream Christmas gifts!",
            isPrivate: true,
            isActive: true,
            category: .christmas,
            addedAt: Date()
        ),
        Wishlist(
            userId: MockUsers.users[1].id,
            name: "Housewarming Gifts",
            description: "Items to make my home feel cozy.",
            isPrivate: false,
            isActive: true,
            category: .housewarming,
            addedAt: Date()
        ),

        // 🎓 Michael Carter - Graduation & Personal
        Wishlist(
            userId: MockUsers.users[2].id,
            name: "Graduation Gifts",
            description: "Some gifts to celebrate my graduation.",
            isPrivate: false,
            isActive: true,
            category: .graduation,
            addedAt: Date()
        ),
        Wishlist(
            userId: MockUsers.users[2].id,
            name: "Personal Wishlist",
            description: "Random things I’ve wanted for a while.",
            isPrivate: false,
            isActive: true,
            category: .personal,
            addedAt: Date()
        ),

        // 💝 Sophia Martinez - Valentine’s & Other
        Wishlist(
            userId: MockUsers.users[3].id,
            name: "Valentine's Day Gifts",
            description: "Romantic gifts for Valentine’s Day.",
            isPrivate: true,
            isActive: true,
            category: .valentines,
            addedAt: Date()
        ),
        Wishlist(
            userId: MockUsers.users[3].id,
            name: "Other Wishlist",
            description: "Miscellaneous gifts I'd like.",
            isPrivate: true,
            isActive: true,
            category: .other,
            addedAt: Date()
        ),

        // 🏠 Liam Brown - Housewarming & Books
        Wishlist(
            userId: MockUsers.users[4].id,
            name: "Housewarming Wishlist",
            description: "Gifts for making my new house feel like home.",
            isPrivate: false,
            isActive: true,
            category: .housewarming,
            addedAt: Date()
        ),
        Wishlist(
            userId: MockUsers.users[4].id,
            name: "Personal Book Collection",
            description: "Books I'd love to add to my personal library.",
            isPrivate: false,
            isActive: true,
            category: .personal,
            addedAt: Date()
        ),

        // 👶 Isabella Wright - Baby Shower & Other
        Wishlist(
            userId: MockUsers.users[5].id,
            name: "Baby Shower Gifts",
            description: "Essentials for my upcoming baby shower.",
            isPrivate: false,
            isActive: true,
            category: .babyShower,
            addedAt: Date()
        ),
        Wishlist(
            userId: MockUsers.users[5].id,
            name: "Other Wishlist",
            description: "Miscellaneous gifts I'd love to receive.",
            isPrivate: false,
            isActive: true,
            category: .other,
            addedAt: Date()
        ),

        // 🎮 Ethan Wilson - Anniversary & Just Because
        Wishlist(
            userId: MockUsers.users[6].id,
            name: "Anniversary Surprises",
            description: "Gifts I’d love for a special anniversary.",
            isPrivate: false,
            isActive: true,
            category: .anniversary,
            addedAt: Date()
        ),
        Wishlist(
            userId: MockUsers.users[6].id,
            name: "Just Because",
            description: "Little things I'd love to receive unexpectedly.",
            isPrivate: false,
            isActive: true,
            category: .justBecause,
            addedAt: Date()
        ),

        // 📚 Olivia Taylor - Graduation Wishlist
        Wishlist(
            userId: MockUsers.users[7].id,
            name: "Graduation Gift Wishlist",
            description: "Memorable gifts for my upcoming graduation.",
            isPrivate: false,
            isActive: true,
            category: .graduation,
            addedAt: Date()
        ),

        // 🏡 Noah Walker - Smart Home Upgrades
        Wishlist(
            userId: MockUsers.users[8].id,
            name: "Smart Home Upgrades",
            description: "Smart home devices I’d like to get.",
            isPrivate: false,
            isActive: true,
            category: .housewarming,
            addedAt: Date()
        ),

        // 🎁 Ava Robinson - Wedding & Just Because
        Wishlist(
            userId: MockUsers.users[9].id,
            name: "Wedding Gift Registry",
            description: "Gifts for our upcoming wedding celebration.",
            isPrivate: false,
            isActive: true,
            category: .wedding,
            addedAt: Date()
        ),
        Wishlist(
            userId: MockUsers.users[9].id,
            name: "Just Because Wishlist",
            description: "Gifts I’d love for no reason at all.",
            isPrivate: false,
            isActive: true,
            category: .justBecause,
            addedAt: Date()
        )
    ]
    
    // Mutable version for modification
       static var mutableWishlists: [Wishlist] {
           get { wishlists }
           set {
               wishlists = newValue
               refresh() // Refresh initializedWishlists when updated
           }
       }

       // Store a cached version of initializedWishlists
       private static var cachedInitializedWishlists: [Wishlist] = []

       // Computed property for initialized wishlists
       static var initializedWishlists: [Wishlist] {
           return cachedInitializedWishlists
       }

       // Refresh method to update initializedWishlists when needed
       static func refresh() {
           cachedInitializedWishlists = wishlists.map { wishlist in
               var updatedWishlist = wishlist
               updatedWishlist.wishGifts = MockWishGifts.wishGifts.filter { $0.wishListId == wishlist.id }
               return updatedWishlist
           }
       }

}




