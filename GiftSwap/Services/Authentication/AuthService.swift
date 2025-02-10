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
    @Published var isLoggingOut: Bool = false
    private var cancellables = Set<AnyCancellable>()
    @AppStorage("isAuthenticated") private var isAuthenticated: Bool = false

    private init() {}

    func login(email: String, password: String) -> AnyPublisher<User?, Error> {
        return UserService.shared.fetchUserByEmailAndPassword(email: email, password: password)
            .handleEvents(receiveOutput: { user in
                DispatchQueue.main.async {
                    self.currentUser = user
                    withAnimation(.easeInOut(duration: 0.5)) {
                        self.isAuthenticated = true
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



