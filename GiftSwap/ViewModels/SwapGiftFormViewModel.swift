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
    
    let imageManager: GiftImageManager // No @Published, managed by the View

    init(imageManager: GiftImageManager) {
        self.imageManager = imageManager
    }

    func addGiftToSwapBasket() -> String? {
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
            ownerId: UUID(),
            swapStatus: .available,
            addedAt: Date()
        )

        // Add the new gift to GiftService
        _ = SwapGiftService.shared.addGift(newGift)
        
        // Create a SwapBasket entry for the new gift
        let newSwapBasketItem = SwapBasket(
            userId: newGift.ownerId,
            giftId: newGift.id,
            status: .available
        )
        
        // Add to SwapBasketService
        SwapBasketService.shared.addGiftToSwapBasket(newSwapBasketItem)

        return nil
    }

    func removeSelectedImage(_ id: UUID) {
        imageManager.removeImage(id)
    }
}
