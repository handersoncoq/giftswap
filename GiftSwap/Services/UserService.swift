//
//  UserService.swift
//  GiftSwap
//
//  Created by Handerson COQ on 2/1/25.
//

import Foundation
import Combine

class UserService {
    static let shared = UserService()
    private init() {}

    // Mock data for now
    private var users: [User] = MockUsers.users

    // Fetch all users
    func fetchUsers() -> AnyPublisher<[User], Error> {
        return Just(users)
            .delay(for: .seconds(1), scheduler: RunLoop.main) // Simulate network delay
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    // Fetch user by ID
    func fetchUser(byId id: UUID) -> AnyPublisher<User?, Error> {
        let user = users.first { $0.id == id }

        return Just(user)
            .delay(for: .seconds(1), scheduler: RunLoop.main)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    // Add user (mock persistence)
    func addUser(_ user: User) -> AnyPublisher<User, Error> {
        users.append(user)

        return Just(user)
            .delay(for: .seconds(1), scheduler: RunLoop.main)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }

    // Update user (mock persistence)
    func updateUser(_ updatedUser: User) -> AnyPublisher<User, Error> {
        if let index = users.firstIndex(where: { $0.id == updatedUser.id }) {
            users[index] = updatedUser
            return Just(updatedUser)
                .delay(for: .seconds(1), scheduler: RunLoop.main)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } else {
            return Fail(error: NSError(domain: "UserService", code: 404, userInfo: [NSLocalizedDescriptionKey: "User not found"]))
                .eraseToAnyPublisher()
        }
    }

    // Delete user (mock persistence)
    func deleteUser(id: UUID) -> AnyPublisher<Bool, Error> {
        if let index = users.firstIndex(where: { $0.id == id }) {
            users.remove(at: index)
            return Just(true)
                .delay(for: .seconds(1), scheduler: RunLoop.main)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        } else {
            return Fail(error: NSError(domain: "UserService", code: 404, userInfo: [NSLocalizedDescriptionKey: "User not found"]))
                .eraseToAnyPublisher()
        }
    }
}
