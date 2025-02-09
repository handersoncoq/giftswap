//
//  SwapBasketView.swift
//  GiftSwap
//
//  Created by Handerson COQ on 2/8/25.
//

import SwiftUI
import Combine

struct SwapBasketView: View {
    @State private var giftsByCategory: [GiftCategory: [Gift]] = [:]
    @State private var filteredGiftsByCategory: [GiftCategory: [Gift]] = [:]
    @State private var expandedCategories: Set<GiftCategory> = []
    @State private var searchText: String = ""
    @State private var cancellables = Set<AnyCancellable>()

    @State private var showConfirmation = false
    @State private var giftToRemove: Gift?
    @State private var showAlert = false
    @State private var alertMessage = ""

    var body: some View {
        MainLayoutView(isRootView: false) {
            VStack(alignment: .leading) {
                HStack {
                    Text("My Swap Basket")
                        .font(.largeTitle)
                        .bold()
                    Spacer()
                }
                .padding(.vertical)

                searchBar

                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        ForEach(filteredGiftsByCategory.keys.sorted(by: { $0.rawValue < $1.rawValue }), id: \.self) { category in
                            if let gifts = filteredGiftsByCategory[category] {
                                VStack(alignment: .leading, spacing: 10) {
                                    HStack {
                                        Text(category.rawValue.capitalized)
                                            .font(.headline)
                                            .bold()
                                        Spacer()
                                    }

                                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 12), count: 2), spacing: 12) {
                                        ForEach(expandedCategories.contains(category) ? gifts : Array(gifts.prefix(4))) { gift in
                                            SwapBasketGiftCard(gift: gift, onRemove: {
                                                giftToRemove = gift
                                                showConfirmation = true
                                            })
                                            .onTapGesture {
                                                navigateToSwapGiftDetail(gift)
                                            }
                                        }
                                    }

                                    if gifts.count > 4 && !expandedCategories.contains(category) {
                                        Button(action: {
                                            expandedCategories.insert(category)
                                        }) {
                                            Text("Load More")
                                                .font(.body)
                                                .foregroundColor(Color("App_Primary"))
                                        }
                                    }
                                }
                            }
                        }
                    }
                    .padding(.bottom, 50)
                }

                Spacer()
            }
            .padding(.horizontal)
            .navigationBarBackButtonHidden(true)
            .onAppear(perform: loadSwapBasket)
            .alert(alertMessage, isPresented: $showAlert) {
                Button("OK", role: .cancel) { }
            }
            .confirmationDialog("Are you sure you want to remove \(giftToRemove?.name ?? "this gift")?", isPresented: $showConfirmation, titleVisibility: .visible) {
                Button("Remove", role: .destructive) {
                    if let gift = giftToRemove {
                        removeGiftFromSwapBasket(gift)
                    }
                }
                Button("Cancel", role: .cancel) { }
            }
        }
    }

    private var searchBar: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.black.opacity(0.5))

            TextField("Search gifts...", text: $searchText, prompt: Text("Search gifts...")
                .fontWeight(.medium)
                .foregroundColor(.black.opacity(0.5)))
                .onChange(of: searchText) { _, _ in
                    filterGifts()
                }
        }
        .padding(10)
        .background(Color("App_Primary").opacity(0.06))
        .cornerRadius(10)
        .padding(.bottom, 20)
    }

    private func loadSwapBasket() {
        SwapBasketService.shared.fetchAllGiftsInSwapBaskets()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    print("Error fetching swap basket gifts: \(error.localizedDescription)")
                }
            }, receiveValue: { fetchedGifts in
                self.giftsByCategory = Dictionary(grouping: fetchedGifts, by: { $0.category })
                self.filterGifts()
            })
            .store(in: &cancellables)
    }

    private func filterGifts() {
        if searchText.isEmpty {
            filteredGiftsByCategory = giftsByCategory
        } else {
            filteredGiftsByCategory = giftsByCategory.mapValues { gifts in
                gifts.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
            }.filter { !$0.value.isEmpty }
        }
    }

    private func removeGiftFromSwapBasket(_ gift: Gift) {
        giftsByCategory[gift.category]?.removeAll { $0.id == gift.id }
        filterGifts()
        alertMessage = "Gift \"\(gift.name)\" has been removed from your swap basket."
        showAlert = true
    }

    private func navigateToSwapGiftDetail(_ gift: Gift) {
        print("Navigating to details for \(gift.name)")
    }
}


// Preview
struct SwapBasketView_Previews: PreviewProvider {
    static var previews: some View {
        SwapBasketView()
    }
}
