//
//  LoginViewModel.swift
//  GiftSwap
//
//  Created by Handerson COQ on 2/10/25.
//

import Foundation
import Combine
import SwiftUI

class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isLoading: Bool = false
    @Published var loginError: String?
    @Published var isAuthenticated: Bool = false

    private var cancellables = Set<AnyCancellable>()

    func login() {
        isLoading = true
        loginError = nil

        AuthService.shared.login(email: email.lowercased(), password: password)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                self.isLoading = false
                if case .failure(_) = completion {
                    self.loginError = "Invalid email or password."
                }
            }, receiveValue: { user in
                if let _ = user {
                    self.isAuthenticated = true
                } else {
                    self.loginError = "Invalid email or password."
                }
            })
            .store(in: &cancellables)
    }
}




