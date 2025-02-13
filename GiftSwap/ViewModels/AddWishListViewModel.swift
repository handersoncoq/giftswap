//
//  AddWishListViewModel.swift
//  GiftSwap
//
//  Created by Handerson COQ on 2/12/25.
//

import Foundation
import Combine

class AddWishListViewModel: ObservableObject {
    @Published var wishlistName: String = ""
    @Published var wishlistDescription: String = ""
    @Published var selectedCategory: WishlistCategory = .other
    @Published var isPrivate: Bool = false
    
    private var cancellables = Set<AnyCancellable>()
    
    func addWishList() -> String? {
        // Ensure user is logged in
        guard let currentUser = AuthService.shared.currentUser else {
            return "You must be logged in to create a wishlist."
        }
        
        // Validation
        guard !wishlistName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            return "Wishlist name is required."
        }

        // Create a new wishlist object
        let newWishlist = Wishlist(
            userId: currentUser.id,
            name: wishlistName,
            description: wishlistDescription.isEmpty ? nil : wishlistDescription,
            isPrivate: isPrivate,
            category: selectedCategory
        )
        
        // Call WishlistService to add the wishlist
        WishlistService.shared.addWishlist(newWishlist)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print("Error adding wishlist: \(error.localizedDescription)")
                }
            }, receiveValue: { _ in
                print("Wishlist added successfully.")
            })
            .store(in: &cancellables)

        return nil
    }
}
