//
//  GiftMatchingViewModel.swift
//  GiftSwap
//
//  Created by Handerson COQ on 2/16/25.
//

import SwiftUI
import Combine

class GiftMatchingViewModel: ObservableObject {
    @Published var statusText: String = "Looking into your swap basket..."
    @Published var showMatchResult: Bool = false
    @Published var matchedPair: (SwapGift, SwapGift)?
    @Published var selectedGift: SwapGift?
    @Published var showCancelButton: Bool = true
    @Published var showConfirmDialog: Bool = false
    @Published var showSuccessAlert: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    
    let authService: AuthService
    let giftMatchingService: GiftMatchingService
    let notificationService: NotificationService
    
    init(
        authService: AuthService = AuthService.shared,
        giftMatchingService: GiftMatchingService = GiftMatchingService.shared,
        notificationService: NotificationService = NotificationService.shared
    ) {
        self.authService = authService
        self.giftMatchingService = giftMatchingService
        self.notificationService = notificationService
    }
    
    func startMatchingProcess() {
        guard let currentUser = authService.currentUser else {
            print("No logged-in user")
            return
        }
        
        let statuses = [
            "Looking into your swap basket...",
            "Checking your wishlist...",
            "Searching the marketplace..."
        ]
        
        for (index, text) in statuses.enumerated() {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double((index + 1) * 2)) {
                self.statusText = text
            }
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
            self.giftMatchingService.startMatchingProcess(for: currentUser.id)
                .sink(receiveCompletion: { _ in }, receiveValue: { matchedPair in
                    DispatchQueue.main.async {
                        self.matchedPair = matchedPair
                        self.showMatchResult = true
                        self.showCancelButton = false
                    }
                })
                .store(in: &self.cancellables)
        }
    }
    
    func confirmSwap(for gift: SwapGift) {

        GiftMatchingService.shared.updateGiftStatus(gift)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print("Error updating swap status: \(error.localizedDescription)")
                }
            }, receiveValue: { success in
                if success {
                    print("Swap gift status successfully updated to pending.")
                    
                    self.notificationService.sendNotification(
                        to: gift.ownerId,
                        message: "You have received a swap request for '\(gift.name)'. Please review the request."
                    )
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                        self.showSuccessAlert = true
                    }
                }
            })
            .store(in: &cancellables)
        
    }
    
    func matchFound(gift: SwapGift) {
        selectedGift = gift
    }
}
