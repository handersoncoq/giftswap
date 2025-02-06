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
            // Search Bar
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                
                TextField("Search gifts...", text: $viewModel.searchText, prompt: Text("Search gifts...").fontWeight(.medium).foregroundColor(.gray))
            }
            .padding(10)
            .background(Color.gray.opacity(0.1))
            .cornerRadius(10)
            .padding(.horizontal)
            .padding(.vertical)

            // Categories and Gifts
            ForEach(viewModel.availableCategories, id: \.self) { category in
                if let gifts = viewModel.filteredGiftsByCategory[category], !gifts.isEmpty {
                    VStack(alignment: .leading) {
                        HStack {
                            Text(category.rawValue.capitalized)
                                .font(.title3)
                                .fontWeight(.bold)
                            Image(systemName: viewModel.categoryIcon(for: category))
                                .foregroundColor(Color("App_Primary"))
                        }
                        .padding(.horizontal)

                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 10) {
                                ForEach(gifts.prefix(10)) { gift in
                                    NavigationLink(destination: GiftDetailView(gift: gift)) {
                                        GiftCard(gift: gift)
                                            .frame(width: 300)
                                    }
                                }

                                if gifts.count > 10 {
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
                            .padding(.vertical)
                        }
                    }
                    .padding(.vertical, 5)
                }
            }
        }
        .onAppear {
            viewModel.fetchGiftsFromSwapBasket()
            viewModel.loadCategoryGifts(category: .fashion)
        }
    }
}



struct GiftBasketView_Previews: PreviewProvider {
    static var previews: some View {
        MarketplaceView()
    }
}
