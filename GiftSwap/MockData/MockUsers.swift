//
//  MockUsers.swift
//  GiftSwap
//
//  Created by Handerson COQ on 2/1/25.
//

import Foundation

struct MockUsers {
    static var users: [User] = [
        User(
            id: UUID(),
            name: "Handerson Coq",
            username: "thesh123",
            password: "password123",
            profilePictureURL: "https://randomuser.me/api/portraits/men/1.jpg",
            rating: 5.0,
            location: "New York, USA"
        ),
        User(
            id: UUID(),
            name: "Emma Johnson",
            username: "emma001",
            password: "securepass",
            profilePictureURL: "https://randomuser.me/api/portraits/women/2.jpg",
            rating: 4.8,
            location: "Los Angeles, USA"
        ),
        User(
            id: UUID(),
            name: "Michael Carter",
            username: "michaelcar",
            password: "mikePass99",
            profilePictureURL: "https://randomuser.me/api/portraits/men/3.jpg",
            rating: 4.5,
            location: "Chicago, USA"
        ),
        User(
            id: UUID(),
            name: "Sophia Martinez",
            username: "sophiaMartin",
            password: "martinez2024",
            profilePictureURL: "https://randomuser.me/api/portraits/women/4.jpg",
            rating: 4.9,
            location: "Houston, USA"
        ),
        User(
            id: UUID(),
            name: "Liam Brown",
            username: "liamBro",
            password: "brownie007",
            profilePictureURL: "https://randomuser.me/api/portraits/men/5.jpg",
            rating: 4.7,
            location: "Miami, USA"
        ),
        // New Users for more swaps & matches
        User(
            id: UUID(),
            name: "Isabella Wright",
            username: "isabellaIsright",
            password: "isaPass123",
            profilePictureURL: "https://randomuser.me/api/portraits/women/6.jpg",
            rating: 4.6,
            location: "San Francisco, USA"
        ),
        User(
            id: UUID(),
            name: "Ethan Wilson",
            username: "ethanReal",
            password: "wilsonStrong",
            profilePictureURL: "https://randomuser.me/api/portraits/men/7.jpg",
            rating: 4.8,
            location: "Seattle, USA"
        ),
        User(
            id: UUID(),
            name: "Olivia Taylor",
            username: "oliviaTae",
            password: "oliviaSecure",
            profilePictureURL: "https://randomuser.me/api/portraits/women/8.jpg",
            rating: 5.0,
            location: "Boston, USA"
        ),
        User(
            id: UUID(),
            name: "Noah Walker",
            username: "noahWalk",
            password: "walker007",
            profilePictureURL: "https://randomuser.me/api/portraits/men/9.jpg",
            rating: 4.4,
            location: "Denver, USA"
        ),
        User(
            id: UUID(),
            name: "Ava Robinson",
            username: "avaRobi",
            password: "avaPass321",
            profilePictureURL: "https://randomuser.me/api/portraits/women/10.jpg",
            rating: 4.9,
            location: "Austin, USA"
        )
    ]
    
    
    static var mutableUsers: [User] = users
        
    static var initializedUsers: [User] {
        for i in mutableUsers.indices {
            let userId = mutableUsers[i].id
            mutableUsers[i].wishlists = MockWishlists.mutableWishlists.filter { $0.userId == userId }
            mutableUsers[i].swapBasket = MockSwapBaskets.swapBaskets.filter { $0.userId == userId }
        }
        return mutableUsers
    }

}



