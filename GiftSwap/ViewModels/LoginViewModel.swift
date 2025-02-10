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
    
    @AppStorage("isAuthenticated") var isAuthenticated: Bool = false
    private var cancellables = Set<AnyCancellable>()

    func login() {
        isLoading = true
        loginError = nil

        UserService.shared.fetchUserByEmailAndPassword(email: email.lowercased(), password: password)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                self.isLoading = false
                if case .failure(_) = completion {
                    self.loginError = "Invalid email or password."
                }
            }, receiveValue: { user in
                if let _ = user {
                    DispatchQueue.main.async {
                        self.isAuthenticated = true
                        UserDefaults.standard.setValue(true, forKey: "isAuthenticated") // Persist login state
                    }
                } else {
                    self.loginError = "Invalid email or password."
                }
            })
            .store(in: &cancellables)
    }


    func logout() {
        DispatchQueue.main.async {
            self.isAuthenticated = false
        }
    }
}


