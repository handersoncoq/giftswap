//
//  SwapSelectionViewModel.swift
//  GiftSwap
//
//  Created by Handerson COQ on 2/15/25.
//

import SwiftUI
import Combine

class SwapSelectionViewModel: ObservableObject {
    
    @State var currentUser: User? = AuthService.shared.currentUser
    @Published var availableGifts: [SwapGift] = []
    @Published var selectedGift: SwapGift?
    @Published var showConfirmationDialog = false
    @Published var navigateToSwapBasket = false  // Controls navigation
    @Published var showSuccessAlert = false  //  Shows alert after swap confirmation

    private var cancellables = Set<AnyCancellable>()

    init() {
        fetchAvailableGifts()
    }

    func fetchAvailableGifts() {
        
        SwapBasketService.shared.fetchUserSwapBasketGifts(userId: currentUser?.id ?? UUID())
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print("Error fetching swap gifts: \(error.localizedDescription)")
                }
            }, receiveValue: { [weak self] gifts in
                DispatchQueue.main.async {
                    self?.availableGifts = gifts.filter { $0.swapStatus == .available }
                }
            })
            .store(in: &cancellables)
    }

    func selectGift(_ gift: SwapGift) {
        if selectedGift?.id == gift.id {
            selectedGift = nil
        } else {
            selectedGift = gift
        }
        print("Selected gift: \(selectedGift?.name ?? "None")")
    }

    func confirmSwap() {
        guard let selectedGift = selectedGift else { return }

        SwapBasketService.shared.updateSwapStatus(for: selectedGift.id, to: .pending)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print("Error updating swap status: \(error.localizedDescription)")
                }
            }, receiveValue: { success in
                if success {
                    print("Swap confirmed for gift: \(selectedGift.name), Status updated to: pending")

                    self.showSuccessAlert = true
                    self.navigateToSwapBasket = true
                }
            })
            .store(in: &cancellables)
    }
    
    func updateGiftStatus(_ gift: SwapGift, to newStatus: SwapStatus) {
        SwapBasketService.shared.updateSwapStatus(for: gift.id, to: newStatus)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print("Error updating gift status: \(error.localizedDescription)")
                }
            }, receiveValue: { success in
                if success {
                    if let index = self.availableGifts.firstIndex(where: { $0.id == gift.id }) {
                        self.availableGifts[index].swapStatus = newStatus
                    }
                }
            })
            .store(in: &cancellables)
    }



}
