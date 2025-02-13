//
//  AddWishGiftView.swift
//  GiftSwap
//
//  Created by Handerson COQ on 2/10/25.
//

import SwiftUI
import PhotosUI
import Combine

struct AddWishGiftView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var navigateToWishlistDetailView = false
    @State private var isManualEntry = false
    let wishlist: Wishlist
    @State var selectedWishlist: UUID?
    
    @StateObject private var viewModel: WishGiftFormViewModel
    
    init(wishlist: Wishlist) {
        self.wishlist = wishlist
        _viewModel = StateObject(wrappedValue: WishGiftFormViewModel(wishlist: wishlist))
        _selectedWishlist = State(initialValue: wishlist.id)
    }
    
    var body: some View {
        MainLayoutView(isRootView: false) {
            VStack(alignment: .leading, spacing: 0) {
                Text("Add Gift to Your Wishlist")
                    .font(.largeTitle)
                    .bold()
                    .padding()
                    .padding(.bottom, 20)
                
                ScrollView(showsIndicators: false) {
                    VStack(spacing: 20) {
                        modeToggle
                        
                        if isManualEntry {
                            giftImagesPicker
                        } else {
                            storeLinkField
                            fetchDetailsButton
                            fetchedImages
                        }
                        
                        giftInfoFields
                        
                        HStack(spacing: 16) {
                            categoryPicker
                                .frame(maxWidth: .infinity, alignment: .leading)
                            wishlistPicker.frame(maxWidth: .infinity, alignment: .trailing)
                        }.padding(.top, -20)
                        
                        addGiftButton
                    }
                }
                .padding(.horizontal)
            }
            .alert(alertMessage, isPresented: $showAlert) {
                Button("OK", role: .cancel) {
                    if navigateToWishlistDetailView {
                        navigateToWishlistDetailView = true
                    }
                }
            }
            .navigationDestination(isPresented: $navigateToWishlistDetailView) {
                WishListDetailView(wishlist: wishlist)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
    
    // MARK: - Mode Toggle (Auto-Fetch vs Manual Entry)
    private var modeToggle: some View {
        Picker("Gift Entry Mode", selection: $isManualEntry) {
            Text("Auto Fetch").tag(false)
            Text("Manual Entry").tag(true)
        }
        .pickerStyle(SegmentedPickerStyle())
        .cornerRadius(10)
        .padding(.bottom, 40)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color("App_Neutral"), lineWidth: 1)
        )
        .onAppear {
            UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(Color("App_Primary"))
            UISegmentedControl.appearance().backgroundColor = UIColor.clear
            
        }
    }
    
    // MARK: - Fetched Images Display
    private var fetchedImages: some View {
        VStack(alignment: .leading, spacing: 10) {
            if !viewModel.images.isEmpty {
                Text("Fetched Images")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(viewModel.images, id: \.self) { imageUrl in
                            AsyncImage(url: URL(string: imageUrl)) { image in
                                image.resizable()
                                    .scaledToFill()
                                    .frame(width: 80, height: 80)
                                    .clipShape(RoundedRectangle(cornerRadius: 8))
                            } placeholder: {
                                ProgressView()
                            }
                        }
                    }
                }
            }
        }
    }
    
    // MARK: - Store Link Input Field
    private var storeLinkField: some View {
        AppTextField(placeholder: "Enter Product Link*", text: $viewModel.storeLink)
    }
    
    // MARK: - Fetch Details Button
    private var fetchDetailsButton: some View {
        SecondaryButton(
            action: {
                viewModel.fetchGiftDetails()
            },
            title: "Fetch Details",
            isLoading: viewModel.isLoading
        )
        .padding(.top, -10)
        .padding(.bottom, 20)
        .disabled(viewModel.isLoading || viewModel.storeLink.isEmpty)
        .alert(viewModel.errorMessage ?? "Something went wrong...", isPresented: $viewModel.showError) {
            Button("OK", role: .cancel) { }
        }
    }
    
    
    private var giftImagesPicker: some View {
        GiftImagesPickerView(
            imageManager: viewModel.imageManager,
            removeFetchedImage: { viewModel.removeFetchedImage($0) }
        )
    }
    
    
    // MARK: - Gift Info Fields
    private var giftInfoFields: some View {
        VStack(alignment: .leading, spacing: 0) {
            AppTextField(placeholder: "Gift Name*", text: $viewModel.name, characterLimit: 50)
            AppTextField(placeholder: "Gift Description*", text: $viewModel.description, characterLimit: 250, isMultiline: true)
            
            
            HStack(spacing: 16) {
                AppTextField(placeholder: "Currency (e.g., USD, EUR)", text: $viewModel.currency)
                    .frame(maxWidth: .infinity, alignment: .leading)
                AppTextField(placeholder: "Price", text: $viewModel.priceString, keyboardType: .decimalPad)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                
            }
            
            
            if isManualEntry {
                AppTextField(placeholder: "Store Link*", text: $viewModel.storeLink)
            }
        }
    }
    
    
    // MARK: - Gift Category Picker
    private var categoryPicker: some View {
        VStack(alignment: .center, spacing: 0) {
            Text("Category")
                .font(.headline)
            
            Picker("Select a category", selection: $viewModel.selectedCategory) {
                ForEach(GiftCategory.allCases, id: \.self) { category in
                    Text(category.rawValue.capitalized)
                }
            }
            .pickerStyle(MenuPickerStyle())
        }
    }
    
    private var wishlistPicker: some View {
        VStack(alignment: .center, spacing: 0) {
            Text("Wishlist")
                .font(.headline)

            ZStack {
                if let user = AuthService.shared.currentUser, let userWishlists = user.wishlists, !userWishlists.isEmpty {
                    Picker("Select Wishlist", selection: $selectedWishlist) {
                        ForEach(userWishlists, id: \.id) { wishlist in
                            Text(wishlist.name)
                                .lineLimit(1)
                                .truncationMode(.tail)
                                .tag(wishlist.id)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())
                    .opacity(0.02) // Hides default picker UI

                    HStack {
                        Text(userWishlists.first(where: { $0.id == selectedWishlist })?.name ?? "Select Wishlist")
                            .lineLimit(1)
                            .truncationMode(.tail)
                            .foregroundColor(Color.blue)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Image(systemName: "chevron.down").foregroundColor(Color.blue)
                    }
                    .padding(.horizontal)
                    .allowsHitTesting(false) // Prevents direct interaction with the HStack
                } else {
                    Text("No Wishlists Available")
                        .foregroundColor(.gray)
                }
            }
            .frame(width: 200)
        }
    }

    
    
    
    // MARK: - Add Gift Button
    private var addGiftButton: some View {
        VStack {
            CTAButton(
                label: "Add Gift to Wishlist",
                backgroundColor: Color("App_Primary"),
                action: addGift,
                icon: Image(systemName: "heart")
            )
        }
        .padding(.bottom, 50)
    }
    
    // MARK: - Add Gift Logic
    private func addGift() {
        let result = viewModel.addGiftToWishlist()
        if let errorMessage = result {
            alertMessage = errorMessage
            showAlert = true
        } else {
            alertMessage = "Gift added successfully!"
            showAlert = true
            navigateToWishlistDetailView = true
            presentationMode.wrappedValue.dismiss()
        }
    }
}

#Preview {
    AddWishGiftView(wishlist: Wishlist(
        id: UUID(),
        userId: UUID(),
        name: "Birthday Wishlist",
        description: "My birthday gift ideas",
        isPrivate: false,
        isActive: true,
        category: .birthday
    ))
}

