//
//  SwapSelectionSheetView.swift
//  GiftSwap
//
//  Created by Handerson COQ on 2/15/25.
//

import SwiftUI

struct SwapSelectionSheetView: View {
    @StateObject private var viewModel = SwapSelectionViewModel()
    @Environment(\.dismiss) private var dismiss
    @State private var shouldDismissSheet = false
    var onDismiss: () -> Void
    @State var isPending = false;
    
    var body: some View {
        VStack{
            VStack {
                SheetHandle()
                // Title
                Text("Select a Gift for Swap")
                    .font(.title2)
                    .bold()
                    .padding(.top)
                
                // Gift Categories ScrollView
                ScrollView(.vertical, showsIndicators: false) {
                    ForEach(groupGiftsByCategory(), id: \.key) { category, gifts in
                        CategorySectionView(
                            category: category,
                            gifts: gifts,
                            viewModel: viewModel
                        )
                    }
                }
                .padding(.top, 25)
                
                // Confirm Swap Button
                SecondaryButton(
                    action: {
                        if viewModel.selectedGift != nil {
                            viewModel.showConfirmationDialog = true
                        }
                    },
                    label: "Confirm Swap"
                )
                .disabled(viewModel.selectedGift == nil)
                .padding(.bottom, 15)
            }
            .padding()
            .confirmationDialog("Confirm Swap", isPresented: $viewModel.showConfirmationDialog) {
                Button("Yes, Confirm") {
                    viewModel.confirmSwap()
                    isPending = true
                }
                Button("Cancel", role: .destructive) {}
            } message: {
                Text("Are you sure you want to swap this gift?")
            }
            .alert("Your swap request has successfully been sent.", isPresented: $viewModel.showSuccessAlert) {
                Button("OK") {
                    isPending = false
                    dismiss()
                    onDismiss()
                }
            }
            FooterView()
        }.overlay(isPending ? LoadingOverlayView() : nil
        )
    }
    
    // Group gifts by category
    private func groupGiftsByCategory() -> [(key: GiftCategory, value: [SwapGift])] {
        guard !viewModel.availableGifts.isEmpty else { return [] }
        return Dictionary(grouping: viewModel.availableGifts, by: { $0.category })
            .sorted { $0.key.rawValue < $1.key.rawValue }
    }
}

// MARK: - Category Section
struct CategorySectionView: View {
    let category: GiftCategory
    let gifts: [SwapGift]
    @ObservedObject var viewModel: SwapSelectionViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            // Category Title
            Text(category.rawValue.capitalized)
                .font(.headline)
                .padding(.leading)
            
            // Gift Grid
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                ForEach(gifts) { gift in
                    SwapGiftSelectionCard(
                        gift: gift,
                        isSelected: viewModel.selectedGift == gift,
                        onSelect: {
                            viewModel.selectGift(gift)
                        }
                    )
                }
            }
        }
        .padding(.vertical, 5)
    }
}

// MARK: - Swap Gift Selection Card
struct SwapGiftSelectionCard: View {
    let gift: SwapGift
    let isSelected: Bool
    let onSelect: () -> Void
    
    var body: some View {
        GiftSelectionCard(
            gift: gift,
            isSelected: .constant(isSelected),
            onSelect: onSelect
        )
        .id(gift.id)
        .scaleEffect(isSelected ? 1.05 : 1.0)
        .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isSelected)
    }
}

// MARK: - Preview
#Preview {
    SwapSelectionSheetView(onDismiss: {})
}
