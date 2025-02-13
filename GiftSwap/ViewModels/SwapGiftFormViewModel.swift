//
//  AddGiftViewModel.swift
//  GiftSwap
//
//  Created by Handerson COQ on 2/9/25.
//

import SwiftUI
import Combine

class SwapGiftFormViewModel: ObservableObject {
    @Published var giftName = ""
    @Published var giftDescription = ""
    @Published var giftValue = ""
    @Published var storeLink = ""
    @Published var selectedCategory: GiftCategory = .other
    
    let imageManager: GiftImageManager
    private var cancellables = Set<AnyCancellable>()

    init(imageManager: GiftImageManager) {
        self.imageManager = imageManager
    }

    func addGiftToSwapBasket() -> String? {
        guard let userId = AuthService.shared.currentUser?.id else {
            return "User must be logged in to add a gift."
        }
        guard !giftName.isEmpty else { return "Gift name is required." }
        guard !giftDescription.isEmpty else { return "Gift description is required." }
        guard let value = Double(giftValue), value > 0 else { return "Valid gift value is required." }
        guard !imageManager.imagePreviews.isEmpty else { return "At least one image is required." }

        let newGift = SwapGift(
            name: giftName,
            description: giftDescription,
            imageURLs: imageManager.saveImagesTemporarily(),
            value: value,
            isAvailable: true,
            storeLink: storeLink.isEmpty ? nil : storeLink,
            category: selectedCategory,
            ownerId: userId,
            swapStatus: .available,
            addedAt: Date()
        )

        SwapGiftService.shared.addGift(newGift)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print("Error adding swap gift: \(error.localizedDescription)")
                }
            }, receiveValue: { addedGift in
                let newSwapBasketItem = SwapBasket(
                    userId: addedGift.ownerId,
                    giftId: addedGift.id,
                    status: .available
                )

                SwapBasketService.shared.addGiftToSwapBasket(newSwapBasketItem)
            })
            .store(in: &cancellables)

        return nil
    }

    func removeSelectedImage(_ id: UUID) {
        imageManager.removeImage(id)
    }
}

