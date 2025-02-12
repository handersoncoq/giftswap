//
//  MockUsers.swift
//  GiftSwap
//
//  Created by Handerson COQ on 2/1/25.
//

import Foundation

struct MockUsers {
    static let users: [User] = [
        User(
            name: "Handerson Coq",
            username: "thesh123",
            password: "password123",
            profilePictureURL: "https://randomuser.me/api/portraits/men/1.jpg",
            rating: 5.0,
            location: "New York, USA"
        ),
        User(
            name: "Emma Johnson",
            username: "emma001",
            password: "securepass",
            profilePictureURL: "https://randomuser.me/api/portraits/women/2.jpg",
            rating: 4.8,
            location: "Los Angeles, USA"
        ),
        User(
            name: "Michael Carter",
            username: "michael.carter@example.com",
            password: "mikePass99",
            profilePictureURL: "https://randomuser.me/api/portraits/men/3.jpg",
            rating: 4.5,
            location: "Chicago, USA"
        ),
        User(
            name: "Sophia Martinez",
            username: "sophia.martinez@example.com",
            password: "martinez2024",
            profilePictureURL: "https://randomuser.me/api/portraits/women/4.jpg",
            rating: 4.9,
            location: "Houston, USA"
        ),
        User(
            name: "Liam Brown",
            username: "liam.brown@example.com",
            password: "brownie007",
            profilePictureURL: "https://randomuser.me/api/portraits/men/5.jpg",
            rating: 4.7,
            location: "Miami, USA"
        )
    ]
}

