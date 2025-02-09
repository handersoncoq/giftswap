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
            imageURLs: saveImagesTemporarily(), // TEMPORARY
            value: value,
            isAvailable: true,
            storeLink: storeLink.isEmpty ? nil : storeLink,
            category: selectedCategory,
            ownerId: UUID(),
            swapStatus: .inBasket,
            addedAt: Date()
        )

        // Add the new gift to GiftService
        _ = GiftService.shared.addGift(newGift)
        
        // Create a SwapBasket entry for the new gift
        let newSwapBasketItem = SwapBasket(
            userId: newGift.ownerId,
            giftId: newGift.id,
            status: .inBasket
        )
        
        // add it to SwapBasketService
        SwapBasketService.shared.addGiftToSwapBasket(newSwapBasketItem)

        return nil
    }
    
    // TEMPORARY:
    func saveImagesTemporarily() -> [String] {
        var imageURLs: [String] = []

        for (index, image) in imagePreviews.enumerated() {
            if let imageData = image.jpegData(compressionQuality: 0.8) { // Convert to Data
                let filename = "gift_image_\(index).jpg"
                let tempURL = FileManager.default.temporaryDirectory.appendingPathComponent(filename)

                do {
                    try imageData.write(to: tempURL) // Save to temp storage
                    imageURLs.append(tempURL.absoluteString) // Store the file URL as string
                } catch {
                    print("Error saving image: \(error.localizedDescription)")
                }
            }
        }

        return imageURLs
    }


}
