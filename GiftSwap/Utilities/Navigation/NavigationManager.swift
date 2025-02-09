//
//  NavigationManager.swift
//  GiftSwap
//
//  Created by Handerson COQ on 2/7/25.
//

import SwiftUI

class NavigationManager: ObservableObject {
    @Published var path: [AnyHashable] = []

    func popToRoot() {
        path.removeAll()
    }
}


