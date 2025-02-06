//
//  MockWishLists.swift
//  GiftSwap
//
//  Created by Handerson COQ on 2/1/25.
//

import Foundation

struct MockWishlists {
    static let wishlists: [Wishlist] = [
        Wishlist(
            userId: MockUsers.users[0].id,
            name: "Birthday Wishlist",
            description: "Gifts I'd love to receive for my upcoming birthday!",
            isPrivate: false,
            isActive: true,
            category: .birthday,
            addedAt: Date()
        ),
        Wishlist(
            userId: MockUsers.users[1].id,
            name: "Christmas Wishlist",
            description: "My dream Christmas gifts!",
            isPrivate: true,
            isActive: true,
            category: .christmas,
            addedAt: Date()
        ),
        Wishlist(
            userId: MockUsers.users[2].id,
            name: "Anniversary Gift Ideas",
            description: "Some ideas for my partner's anniversary gift.",
            isPrivate: false,
            isActive: true,
            category: .anniversary,
            addedAt: Date()
        ),
        Wishlist(
            userId: MockUsers.users[3].id,
            name: "Personal Shopping List",
            description: "Things I'd like to buy for myself someday.",
            isPrivate: true,
            isActive: true,
            category: .personal,
            addedAt: Date()
        ),
        Wishlist(
            userId: MockUsers.users[4].id,
            name: "Wedding Gift Registry",
            description: "A collection of gifts for our wedding day.",
            isPrivate: false,
            isActive: true,
            category: .wedding,
            addedAt: Date()
        )
    ]
}
