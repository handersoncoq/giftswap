//
//  AddWishListView.swift
//  GiftSwap
//
//  Created by Handerson COQ on 2/12/25.
//

import SwiftUI

struct AddWishListView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var viewModel = AddWishListViewModel()
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var navigateToWishlist = false

    var body: some View {
        MainLayoutView(isRootView: false) {
            VStack(alignment: .leading, spacing: 0) {
                Text("Create a New Wishlist")
                    .font(.largeTitle)
                    .bold()
                    .padding()
                    .padding(.bottom, 20)

                ScrollView(showsIndicators: false) {
                    VStack(spacing: 20) {
                        wishListInfoFields
                        wishListCategoryPicker
                        visibilityToggle
                        createWishListButton
                    }
                }
                .padding(.horizontal)
            }
            .alert(alertMessage, isPresented: $showAlert) {
                Button("OK", role: .cancel) {
                    if navigateToWishlist {
                        navigateToWishlist = true
                    }
                }
            }
            .navigationDestination(isPresented: $navigateToWishlist) {
                WishlistView()
            }
        }
        .navigationBarBackButtonHidden(true)
    }

    // MARK: - Wishlist Info Fields
    private var wishListInfoFields: some View {
        VStack(alignment: .leading, spacing: 0) {
            AppTextField(placeholder: "Wishlist Name*", text: $viewModel.wishlistName, characterLimit: 50)
            AppTextField(placeholder: "Wishlist Description", text: $viewModel.wishlistDescription, characterLimit: 250, isMultiline: true)
        }
    }

    // MARK: - Wishlist Category Picker
    private var wishListCategoryPicker: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Category")
                .font(.headline)

            Picker("Select a Category", selection: $viewModel.selectedCategory) {
                ForEach(WishlistCategory.allCases, id: \.self) { category in
                    Text(category.rawValue.capitalized)
                }
            }
            .pickerStyle(MenuPickerStyle())
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.top, -22)
    }

    // MARK: - Visibility Toggle
    private var visibilityToggle: some View {
        Toggle("Make Wishlist Private", isOn: $viewModel.isPrivate)
            .padding(.vertical, 10)
    }

    // MARK: - Create Wishlist Button
    private var createWishListButton: some View {
        VStack {
            CTAButton(
                label: "Create Wishlist",
                backgroundColor: Color("App_Primary"),
                action: createWishlist,
                icon: Image(systemName: "list.bullet")
            )
        }
        .padding(.bottom, 50)
    }

    // MARK: - Create Wishlist Logic
    private func createWishlist() {
        let result = viewModel.addWishList()
        if let errorMessage = result {
            alertMessage = errorMessage
            showAlert = true
        } else {
            alertMessage = "Wishlist created successfully!"
            showAlert = true
            navigateToWishlist = true
        }
    }
}

#Preview {
    AddWishListView()
}
