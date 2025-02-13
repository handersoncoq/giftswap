//
//  AuthService.swift
//  GiftSwap
//
//  Created by Handerson COQ on 2/10/25.
//

import Foundation
import Combine
import SwiftUI

class AuthService: ObservableObject {
    static let shared = AuthService()
    @Published var currentUser: User?
//     @Published var currentUser: User? = MockUsers.initializedUsers.first
    @Published var isLoggingOut: Bool = false
    private var cancellables = Set<AnyCancellable>()
    @AppStorage("isAuthenticated") private var isAuthenticated: Bool = false

    private init() {}

    func login(username: String, password: String) -> AnyPublisher<User?, Error> {
        return UserService.shared.fetchUserByUsernameAndPassword(username: username, password: password)
            .handleEvents(receiveOutput: { user in
                DispatchQueue.main.async {
                    if let user = user {
                        self.currentUser = user
                        withAnimation(.easeInOut(duration: 0.5)) {
                            self.isAuthenticated = true
                        }
                    } else {
                        print("Login failed: User not found")
                    }
                }
            })
            .delay(for: .seconds(0.6), scheduler: RunLoop.main)
            .eraseToAnyPublisher()
    }



    func logout() {
        isLoggingOut = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
            withAnimation(.easeInOut(duration: 0.4)) {
                self.currentUser = nil
                self.isAuthenticated = false
                self.isLoggingOut = false
            }
        }
    }

    func isLoggedIn() -> Bool {
        return isAuthenticated && currentUser != nil
    }
}



