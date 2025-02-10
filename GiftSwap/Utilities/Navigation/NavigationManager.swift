//
//  NavigationManager.swift
//  GiftSwap
//
//  Created by Handerson COQ on 2/7/25.
//

import SwiftUI

class NavigationManager: ObservableObject {
    static let shared = NavigationManager()
    
    @Published var path: [Destination] = []
    
    func popToRoot() {
        path.removeAll()
    }

    func navigateTo(_ destination: Destination) {
        DispatchQueue.main.async {
            self.path.append(destination)
        }
    }
}



