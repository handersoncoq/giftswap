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
        VStack(alignment: .leading) {
            Text("\(category.rawValue.capitalized) Gifts").font(.largeTitle)
                .bold().padding()
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                
                TextField("Search gifts...", text: $viewModel.searchText, prompt: Text("Search gifts...").fontWeight(.medium).foregroundColor(.gray))
                    .onChange(of: viewModel.searchText) { oldValue, newValue in
                        // Reset pagination when search text changes
                        currentPage = 1
                        updatePaginatedGifts()
                    }

            }
            .padding(10)
            .background(Color.gray.opacity(0.1))
            .cornerRadius(10)
            .padding(.horizontal)
            .padding(.bottom, 20)

            // Gifts Grid
            ScrollView {
                LazyVGrid(columns: [
                    GridItem(.fixed(180)),
                    GridItem(.fixed(180))
                ], spacing: 4) {
                    ForEach(paginatedGifts) { gift in
                        NavigationLink(destination: GiftDetailView(gift: gift)) {
                            SmallGiftCard(gift: gift)
                        }
                    }
                }
                .padding(.horizontal)

                // Pagination Navigation Indicators
                if viewModel.filteredGifts.count > itemsPerPage {
                    HStack {
                        Button(action: previousPage) {
                            Image(systemName: "arrow.left.circle.fill")
                                .font(.largeTitle)
                                .foregroundColor(currentPage > 1 ? .blue : .gray)
                        }
                        .disabled(currentPage <= 1)

                        Spacer()

                        Text("Page \(currentPage)")
                            .font(.headline)

                        Spacer()

                        Button(action: nextPage) {
                            Image(systemName: "arrow.right.circle.fill")
                                .font(.largeTitle)
                                .foregroundColor(currentPage < totalPages ? .blue : .gray)
                        }
                        .disabled(currentPage >= totalPages)
                    }
                    .padding()
                }
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                viewModel.loadCategoryGifts(category: category)
                updatePaginatedGifts()
            }
        }
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





