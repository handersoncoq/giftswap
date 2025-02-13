//
//  SwapBasketViewModel.swift
//  GiftSwap
//
//  Created by Handerson COQ on 2/8/25.
//

import SwiftUI
import Combine

class SwapBasketViewModel: ObservableObject {
    @Published var giftsByCategory: [GiftCategory: [SwapGift]] = [:]
    private var allGiftsByCategory: [GiftCategory: [SwapGift]] = [:]
    @Published var searchText: String = ""
    @Published var pendingSwapRequests: [SwapGift] = []
    @Published var isLoading: Bool = false

    private var cancellables = Set<AnyCancellable>()

    init() {
        fetchUserSwapBasketGifts()
        NotificationCenter.default.addObserver(self, selector: #selector(refreshSwapBasket), name: NSNotification.Name("RefreshSwapBasket"), object: nil)
    }
    
    // Fetch ONLY the current user's swap basket gifts
        func fetchUserSwapBasketGifts() {
            guard let currentUser = AuthService.shared.currentUser else {
                print("No logged-in user found.")
                return
            }

            isLoading = true
            print("Fetching swap gifts for user ID: \(currentUser.id)")

            SwapBasketService.shared.fetchUserSwapBasketGifts(userId: currentUser.id)
                .receive(on: DispatchQueue.main)
                .sink(receiveCompletion: { completion in
                    self.isLoading = false
                    if case .failure(let error) = completion {
                        print("Error fetching user swap gifts: \(error.localizedDescription)")
                    }
                }, receiveValue: { fetchedGifts in
                    print("Fetched \(fetchedGifts.count) swap gifts for user ID: \(currentUser.id)")

                    // Group them by category
                    self.allGiftsByCategory = Dictionary(grouping: fetchedGifts, by: { $0.category })
                    self.filterGifts()
                })
                .store(in: &cancellables)
        }



    func removeGift(_ gift: SwapGift) {
        SwapBasketService.shared.removeGiftFromSwapBasket(giftId: gift.id)
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
    
    func filterGifts() {
            if searchText.isEmpty {
                giftsByCategory = allGiftsByCategory
            } else {
                giftsByCategory = allGiftsByCategory.mapValues { gifts in
                    gifts.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
                }.filter { !$0.value.isEmpty }
            }
        }


    
    // Refresh wishlist
    @objc func refreshSwapBasket() {
        isLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.fetchUserSwapBasketGifts()
        }
    }
    
    
    func getGiftOwner(gift: SwapGift, completion: @escaping (String) -> Void) {
        UserService.shared.fetchUser(byGiftId: gift.id)
            .sink(receiveCompletion: { result in
                if case .failure(let error) = result {
                    print("Error fetching user: \(error.localizedDescription)")
                    completion("Unknown Owner")
                }
            }, receiveValue: { user in
                completion(user?.username ?? "Unknown Owner")
            })
            .store(in: &cancellables)
    }



}
