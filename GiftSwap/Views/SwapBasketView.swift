//
//  SwapBasketView.swift
//  GiftSwap
//
//  Created by Handerson COQ on 2/8/25.
//

import SwiftUI
import Combine

struct SwapBasketView: View {
    @StateObject private var viewModel = SwapBasketViewModel()
    @State private var showConfirmation = false
    @State private var giftToRemove: Gift?
    @State private var showAlert = false
    @State private var alertMessage = ""

    var body: some View {
        MainLayoutView(isRootView: false) {
            VStack(alignment: .leading) {
                titleView
                searchBar
                giftList
                Spacer()
            }
            .padding(.horizontal)
            .navigationBarBackButtonHidden(true)
            .alert(alertMessage, isPresented: $showAlert) {
                Button("OK", role: .cancel) { }
            }
            .confirmationDialog(
                confirmationMessage,
                isPresented: $showConfirmation,
                titleVisibility: .visible
            ) {
                removeGiftButton
                cancelButton
            }
        }
    }

    // MARK: - Subviews

    private var titleView: some View {
        HStack {
            Text("My Swap Basket")
                .font(.largeTitle)
                .bold()
            Spacer()
        }
        .padding(.vertical)
    }

    private var searchBar: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.black.opacity(0.5))

            TextField("Search gifts...", text: $viewModel.searchText, prompt: Text("Search gifts...")
                .fontWeight(.medium)
                .foregroundColor(.black.opacity(0.5)))
        }
        .padding(10)
        .background(Color("App_Primary").opacity(0.06))
        .cornerRadius(10)
        .padding(.bottom, 20)
    }

    private var giftList: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                ForEach(viewModel.giftsByCategory.keys.sorted(by: { $0.rawValue < $1.rawValue }), id: \.self) { category in
                    if let gifts = viewModel.giftsByCategory[category] {
                        categorySection(category: category, gifts: gifts)
                    }
                }
            }
            .padding(.bottom, 50)
        }
    }

    private func categorySection(category: GiftCategory, gifts: [Gift]) -> some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(category.rawValue.capitalized)
                    .font(.headline)
                    .bold()
                Spacer()
            }

            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 12), count: 2), spacing: 12) {
                ForEach(gifts) { gift in
                    NavigationLink(destination: SwapGiftDetailView(gift: gift, viewModel: viewModel)) {
                        SwapBasketGiftCard(gift: gift, onRemove: {
                            giftToRemove = gift
                            showConfirmation = true
                        })
                    }
                }
            }
        }
    }

    // MARK: - Confirmation Dialog

    private var confirmationMessage: String {
        "Are you sure you want to remove \(giftToRemove?.name ?? "") from your basket?"
    }

    private var removeGiftButton: some View {
        Button("Remove", role: .destructive) {
            if let gift = giftToRemove {
                viewModel.removeGift(gift)
                alertMessage = "Gift \"\(gift.name)\" has been removed from your swap basket."
                showAlert = true
            }
        }
    }

    private var cancelButton: some View {
        Button("Cancel", role: .cancel) { }
    }
}


// Preview
struct SwapBasketView_Previews: PreviewProvider {
    static var previews: some View {
        SwapBasketView()
    }
}
