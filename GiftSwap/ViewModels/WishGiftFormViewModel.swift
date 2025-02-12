//
//  WishGiftFormViewModel.swift
//  GiftSwap
//
//  Created by Handerson COQ on 2/10/25.
//

import Foundation
import Combine
import UIKit
import _PhotosUI_SwiftUI
import SwiftUI

struct WishGiftImage: Identifiable, Equatable {
    let id = UUID()
    let image: UIImage
}

class WishGiftFormViewModel: ObservableObject {
    @Published var storeLink: String = ""
    @Published var name: String = ""
    @Published var description: String = ""
    @Published var category: GiftCategory = .other
    @Published var occasion: WishlistCategory = .other
    @Published var images: [String] = []
    @Published var currency: String = ""
    @Published var brand: String = ""
    @Published var fetchedImageURLs: [String] = []
    @Published var priceString: String = ""
    @Published var selectedCategory: GiftCategory = .other
    @Published var selectedOccasion: WishlistCategory = .other
    @Published var imageManager = GiftImageManager()


    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    @Published var showError = false

    
    @Published var price: Double? {
            didSet {
                priceString = price.map { String(format: "%.2f", $0) } ?? ""
            }
        }
    

    private var cancellables = Set<AnyCancellable>()
    

    func fetchGiftDetails() {
        guard !storeLink.isEmpty else {
            errorMessage = "Please enter a valid product link."
            showError = true
            return
        }

        isLoading = true
        errorMessage = nil

        WishGiftService.shared.fetchProductDetails(from: storeLink)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                self.isLoading = false
                if case .failure(let error) = completion {
                    self.errorMessage = error.localizedDescription
                    self.showError = true
                }
            }, receiveValue: { extractedGift in
                guard let gift = extractedGift else {
                    self.errorMessage = "Could not extract product details."
                    self.showError = true
                    return
                }

                self.name = gift.name
                self.description = gift.description
                self.images = gift.images
                self.priceString = gift.price != nil ? String(format: "%.2f", gift.price!) : ""
                
                self.currency = gift.currency ?? "USD"
                
                self.brand = gift.brand ?? "n/a"
            })
            .store(in: &cancellables)
    }



    
    func addGiftToWishlist() -> String? {
        // Ensure required fields are filled
        guard !name.isEmpty, !description.isEmpty, !storeLink.isEmpty else {
            return "Please fill in all required fields."
        }
        
        // Ensure at least one image is present
        let allImages = images + imageManager.saveImagesTemporarily()
        guard !allImages.isEmpty else {
            return "At least one image is required."
        }
        
        // Convert priceString to Double safely
        let priceValue = Double(priceString.trimmingCharacters(in: .whitespacesAndNewlines))
        
        let newGift = WishGift(
            name: name,
            description: description,
            category: selectedCategory,
            images: allImages,
            storeLink: storeLink,
            price: priceValue,
            currency: currency,
            brand: brand,
            occasion: selectedOccasion
            
        )
        
        WishGiftService.shared.addWishGift(newGift)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print("Error adding gift: \(error.localizedDescription)")
                }
            }, receiveValue: { addedGift in
                print("Gift added successfully: \(addedGift.name)")
            })
            .store(in: &cancellables)
        
        print("price is \(String(describing: newGift.price))")
        
        DispatchQueue.main.async {
            self.images = self.imageManager.saveImagesTemporarily()
        }
        
        return nil
    }

    
    // TEMPORARY:
    func saveImagesTemporarily() -> [String] {
        return imageManager.saveImagesTemporarily()
    }
    
    func removeFetchedImage(_ url: String) {
            DispatchQueue.main.async {
                withAnimation(.easeInOut(duration: 0.2)) {
                    self.fetchedImageURLs.removeAll { $0 == url }
                }
            }
        }

    func removeSelectedImage(_ id: UUID) {
        imageManager.removeImage(id)
    }


}
