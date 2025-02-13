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
    @Published var currency: String = "USD"
    @Published var brand: String = ""
    @Published var fetchedImageURLs: [String] = []
    @Published var priceString: String = ""
    @Published var selectedCategory: GiftCategory = .other
    @Published var imageManager = GiftImageManager()

    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var showError = false
    @Published var giftsByCategory: [GiftCategory: [WishGift]] = [:]
    
    @Published var searchText: String = ""
    
    private var allGiftsByCategory: [GiftCategory: [WishGift]] = [:]

    private var cancellables = Set<AnyCancellable>()
    
    let wishlist: Wishlist

    @Published var price: Double? {
        didSet {
            priceString = price.map { String(format: "%.2f", $0) } ?? ""
        }
    }

    init(wishlist: Wishlist) {
        self.wishlist = wishlist
        fetchWishGifts()
    }

    // MARK: - Fetch Wish Gifts for a Specific Wishlist
    func fetchWishGifts(for wishlistId: UUID? = nil) {
        guard let wishlistId = wishlistId else {
            print("⚠️ Error: Wishlist ID is nil. Cannot fetch gifts.")
            return
        }

        isLoading = true
        WishGiftService.shared.fetchWishGifts(for: wishlistId) // ✅ Now always passing a non-optional UUID
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                self.isLoading = false
                if case .failure(let error) = completion {
                    print("Error fetching wish gifts: \(error.localizedDescription)")
                }
            }, receiveValue: { fetchedGifts in
                print("✅ Successfully fetched \(fetchedGifts.count) gifts for wishlist ID: \(wishlistId)")
                self.allGiftsByCategory = Dictionary(grouping: fetchedGifts, by: { $0.category })
                self.filterGifts()
            })
            .store(in: &cancellables)
    }



    // MARK: - Fetch Product Details
    func fetchGiftDetails() {
        guard !storeLink.isEmpty else {
            errorMessage = "Please enter a valid product link."
            showError = true
            return
        }

        isLoading = true
        errorMessage = nil

        WishGiftService.shared.fetchProductDetails(from: storeLink)
            .receive(on: DispatchQueue.global(qos: .background)) // 🔥 Process in background
            .sink(receiveCompletion: { completion in
                DispatchQueue.main.async { // ✅ Ensure UI updates are handled in the main thread
                    self.isLoading = false
                    if case .failure(let error) = completion {
                        self.errorMessage = "Error: \(error.localizedDescription)"
                        self.showError = true
                    }
                }
            }, receiveValue: { extractedGift in
                DispatchQueue.main.async {
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
                }
            })
            .store(in: &cancellables)
    }



    // MARK: - Add Gift to Wishlist
    func addGiftToWishlist() -> String? {
        guard !name.isEmpty, !description.isEmpty else {
            return "Please fill in all required fields."
        }

        let allImages = images + imageManager.saveImagesTemporarily()
        guard !allImages.isEmpty else {
            return "At least one image is required."
        }

        let priceValue = Double(priceString.trimmingCharacters(in: .whitespacesAndNewlines))
        
        let newGift = WishGift(
            id: UUID(),
            name: name,
            description: description,
            category: selectedCategory,
            images: allImages,
            storeLink: storeLink,
            price: priceValue,
            currency: currency,
            brand: brand,
            wishListId: wishlist.id
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

        return nil
    }


    // MARK: - Remove Gift from Wishlist
    func removeGift(_ gift: WishGift) {
        WishGiftService.shared.deleteWishGift(id: gift.id)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print("Error removing gift: \(error.localizedDescription)")
                }
            }, receiveValue: { success in
                if success {
                    self.giftsByCategory[gift.category]?.removeAll { $0.id == gift.id }
                }
            })
            .store(in: &cancellables)
    }

    // MARK: - Filter Wish Gifts
    func filterGifts() {
        if searchText.isEmpty {
            giftsByCategory = allGiftsByCategory
        } else {
            giftsByCategory = allGiftsByCategory.mapValues { gifts in
                gifts.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
            }.filter { !$0.value.isEmpty }
        }
    }

    // MARK: - Refresh Wish Gifts
    func refreshWishGifts() {
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.fetchWishGifts()
            self.isLoading = false
        }
    }

    // MARK: - Image Management
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

