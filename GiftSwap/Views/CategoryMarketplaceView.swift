//
//  CategoryMarketplaceView.swift
//  GiftSwap
//
//  Created by Handerson COQ on 2/1/25.
//

import SwiftUI

struct CategoryMarketplaceView: View {
    let category: GiftCategory
    @StateObject private var viewModel = MarketplaceViewModel()
    @State private var currentPage = 1
    @State private var paginatedGifts: [Gift] = []
    private let itemsPerPage = 10
    
    private let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12)
    ]

    var body: some View {
        MainLayoutView(isRootView: false) {
            VStack(alignment: .leading) {
                categoryTitle
                searchBar
                giftsGrid
            }
            .onAppear(perform: loadGifts)
        }
        .navigationBarBackButtonHidden(true)
    }

    private var categoryTitle: some View {
        Text("\(category.rawValue.capitalized) Gifts")
            .font(.largeTitle)
            .bold()
            .padding()
    }

    private var searchBar: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.black.opacity(0.5))
            
            TextField("Search gifts...", text: $viewModel.searchText, prompt: Text("Search gifts...").fontWeight(.medium).foregroundColor(.black.opacity(0.5)))
                .onChange(of: viewModel.searchText) { oldValue, newValue in
                    currentPage = 1
                    updatePaginatedGifts()
                }
        }
        .padding(10)
        .background(Color("App_Primary").opacity(0.06))
        .cornerRadius(10)
        .padding(.horizontal)
        .padding(.bottom, 10)
    }

    private var giftsGrid: some View {
        ScrollView(showsIndicators: false) {
            LazyVGrid(columns: columns, spacing: 18) {
                ForEach(paginatedGifts) { gift in
                    NavigationLink(destination: GiftDetailView(gift: gift)) {
                        SmallGiftCard(gift: gift)
                    }
                }
            }
            .padding(.top, 10)
            .padding(.horizontal)

            if viewModel.filteredGifts.count > itemsPerPage {
                paginationControls
            }
        }
    }

    private var paginationControls: some View {
        HStack {
            Button(action: previousPage) {
                Image(systemName: "arrow.left.circle.fill")
                    .font(.largeTitle)
                    .foregroundColor(currentPage > 1 ? .blue : .gray)
            }
            .disabled(currentPage <= 1)

            Text("\(currentPage) / \(totalPages)")
                .font(.headline)

            Button(action: nextPage) {
                Image(systemName: "arrow.right.circle.fill")
                    .font(.largeTitle)
                    .foregroundColor(currentPage < totalPages ? .blue : .gray)
            }
            .disabled(currentPage >= totalPages)
        }
        .padding()
        .padding(.bottom, 45)
    }

    private var totalPages: Int {
        return (viewModel.filteredGifts.count + itemsPerPage - 1) / itemsPerPage
    }

    private func updatePaginatedGifts() {
        let start = (currentPage - 1) * itemsPerPage
        let end = min(start + itemsPerPage, viewModel.filteredGifts.count)

        if start < viewModel.filteredGifts.count {
            paginatedGifts = Array(viewModel.filteredGifts[0..<end])
        } else {
            paginatedGifts = []
        }
    }

    private func nextPage() {
        if currentPage < totalPages {
            currentPage += 1
            updatePaginatedGifts()
        }
    }

    private func previousPage() {
        if currentPage > 1 {
            currentPage -= 1
            updatePaginatedGifts()
        }
    }

    private func loadGifts() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            viewModel.loadCategoryGifts(category: category)
            updatePaginatedGifts()
        }
    }
}

struct CategoryMarketplaceView_Previews: PreviewProvider {
    static var previews: some View {
        let mockCategory = GiftCategory.electronics
        let mockViewModel = MarketplaceViewModel()

        return NavigationView {
            CategoryMarketplaceView(category: mockCategory)
                .environmentObject(mockViewModel)
        }
    }
}





