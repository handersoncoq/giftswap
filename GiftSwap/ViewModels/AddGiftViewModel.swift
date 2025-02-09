//
//  AddGiftViewModel.swift
//  GiftSwap
//
//  Created by Handerson COQ on 2/9/25.
//

import SwiftUI
import PhotosUI
import Combine

class AddGiftViewModel: ObservableObject {
    @Published var giftName = ""
    @Published var giftDescription = ""
    @Published var giftValue = ""
    @Published var storeLink = ""
    @Published var selectedCategory: GiftCategory = .other
    @Published var selectedImages: [PhotosPickerItem] = []
    @Published var imagePreviews: [UIImage] = []

    private var cancellables = Set<AnyCancellable>()

    init() {
        $selectedImages
            .sink { newSelections in
                self.loadImages(from: newSelections)
            }
            .store(in: &cancellables)
    }

    private func loadImages(from selections: [PhotosPickerItem]) {
        imagePreviews = []
        let dispatchGroup = DispatchGroup()

        for selection in selections.prefix(4) {
            dispatchGroup.enter()
            selection.loadTransferable(type: Data.self) { result in
                switch result {
                case .success(let data):
                    if let data = data, let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self.imagePreviews.append(image)
                        }
                    }
                case .failure(let error):
                    print("Image loading failed: \(error.localizedDescription)")
                }
                dispatchGroup.leave()
            }
        }

        dispatchGroup.notify(queue: .main) {
            print("Finished loading images")
        }
    }

    func addGiftToSwapBasket() -> String? {
        guard !giftName.isEmpty else { return "Gift name is required." }
        guard !giftDescription.isEmpty else { return "Gift description is required." }
        guard let value = Double(giftValue), value > 0 else { return "Valid gift value is required." }
        guard !imagePreviews.isEmpty else { return "At least one image is required." }

        let newGift = Gift(
            name: giftName,
            description: giftDescription,
            imageURLs: imagePreviews.map { _ in "placeholder_image_url" }, // Mocked URLs
            value: value,
            isAvailable: true,
            storeLink: storeLink.isEmpty ? nil : storeLink,
            category: selectedCategory,
            ownerId: UUID(),
            swapStatus: .inBasket,
            addedAt: Date()
        )

        _ = GiftService.shared.addGift(newGift)
        _ = SwapBasketService.shared.fetchAllGiftsInSwapBaskets()

        return nil
    }
}
