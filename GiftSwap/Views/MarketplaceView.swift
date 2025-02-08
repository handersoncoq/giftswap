//
//  MarketplaceView.swift
//  GiftSwap
//
//  Created by Handerson COQ on 1/27/25.
//

import SwiftUI

struct MarketplaceView: View {
    @StateObject private var viewModel = MarketplaceViewModel()

    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing: 16) {
                searchBar
                categoriesAndGifts
            }
        }
        .onAppear(perform: loadData)
    }

    // MARK: - Components

    private var searchBar: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.black.opacity(0.5))
            
            TextField("Search gifts...", text: $viewModel.searchText, prompt: Text("Search gifts...").fontWeight(.medium).foregroundColor(.black.opacity(0.5)))
        }
        .padding(10)
        .background(Color("App_Primary").opacity(0.06))
        .cornerRadius(10)
        .padding(.horizontal)
        .padding(.vertical)
    }

    private var categoriesAndGifts: some View {
        ForEach(viewModel.availableCategories, id: \.self) { category in
            if let gifts = viewModel.filteredGiftsByCategory[category], !gifts.isEmpty {
                CategorySection(category: category, gifts: gifts, viewModel: viewModel)
            }
        }
    }

    // MARK: - Helper Methods

    private func loadData() {
        viewModel.fetchGiftsFromSwapBasket()
        viewModel.loadCategoryGifts(category: .fashion)
    }
}

// MARK: - Subviews

struct CategorySection: View {
    let category: GiftCategory
    let gifts: [Gift]
    let viewModel: MarketplaceViewModel

    var body: some View {
        VStack(alignment: .leading) {
            categoryHeader
            horizontalGiftScroll
        }
        .padding(.vertical, 5)
    }

    private var categoryHeader: some View {
        HStack {
            Text(category.rawValue.capitalized)
                .font(.title3)
                .fontWeight(.bold)
            Image(systemName: viewModel.categoryIcon(for: category))
                .foregroundColor(Color("App_Primary"))
        }
        .padding(.horizontal)
    }

    private var horizontalGiftScroll: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(gifts.prefix(10)) { gift in
                    NavigationLink(destination: GiftDetailView(gift: gift)) {
                        GiftCard(gift: gift)
                            .frame(width: 300)
                    }
                }

                if gifts.count > 10 {
                    viewMoreButton
                }
            }
            .padding(.vertical)
        }
    }

    private var viewMoreButton: some View {
        NavigationLink(destination: CategoryMarketplaceView(category: category)) {
            HStack {
                Text("View More")
                    .font(.subheadline)
                    .foregroundColor(.blue)
                Image(systemName: "arrow.right")
            }
        }
    }
}



struct GiftBasketView_Previews: PreviewProvider {
    static var previews: some View {
        MarketplaceView()
    }
}
