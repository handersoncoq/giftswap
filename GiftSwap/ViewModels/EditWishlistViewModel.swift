//
//  EditWishlistViewModel.swift
//  GiftSwap
//
//  Created by Handerson COQ on 2/11/25.
//

import Foundation
import Combine

class EditWishlistViewModel: ObservableObject {
    @Published var name: String
    @Published var description: String
    @Published var isPrivate: Bool
    @Published var selectedCategory: WishlistCategory

    private var originalWishlist: Wishlist
    private var cancellables = Set<AnyCancellable>()

    init(wishlist: Wishlist) {
        self.originalWishlist = wishlist
        self.name = wishlist.name
        self.description = wishlist.description ?? ""
        self.isPrivate = wishlist.isPrivate
        self.selectedCategory = wishlist.category
    }

    func saveWishlist() -> String? {
        guard !name.isEmpty else {
            return "Wishlist name is required."
        }

        let updatedWishlist = Wishlist(
            id: originalWishlist.id,
            userId: originalWishlist.userId,
            name: name,
            description: description.isEmpty ? nil : description,
            isPrivate: isPrivate,
            category: selectedCategory,
            addedAt: originalWishlist.addedAt
        )

        WishlistService.shared.updateWishlist(updatedWishlist)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print("Error updating wishlist: \(error.localizedDescription)")
                }
            }, receiveValue: { _ in
                print("Wishlist updated successfully!")
            })
            .store(in: &cancellables)

        return nil // No errors
    }
}
