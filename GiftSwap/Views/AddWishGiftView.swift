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
    @StateObject private var viewModel = WishGiftFormViewModel()
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var navigateToWishlist = false
    @State private var isManualEntry = false
    

    var body: some View {
            MainLayoutView(isRootView: false) {
                VStack(alignment: .leading, spacing: 0) {
                    Text("Add a Gift to Your Wishlist")
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
                                
                                occasionPicker
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                            }.padding(.top, -20)
                            
                            addGiftButton
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
                    WishGiftView()
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
        Button(action: {
            viewModel.fetchGiftDetails()
        }) {
            HStack {
                if viewModel.isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                }
                Text(viewModel.isLoading ? "Fetching..." : "Fetch Details")
                    .foregroundColor(.white)
                    .fontWeight(.medium)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color("App_Primary"))
            .cornerRadius(10)
        }
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
            AppTextField(placeholder: "Price", text: $viewModel.priceString, keyboardType: .decimalPad)
         
            AppTextField(placeholder: "Brand", text: $viewModel.brand)
            
            AppTextField(placeholder: "Currency (e.g., USD, EUR)", text: $viewModel.currency)

            if isManualEntry {
                AppTextField(placeholder: "Store Link*", text: $viewModel.storeLink)
            }
        }
    }


    // MARK: - Gift Category Picker
    private var categoryPicker: some View {
        VStack(alignment: .leading, spacing: 0) {
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
    
    private var occasionPicker: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Occasion")
                .font(.headline)

            Picker("Select an occasion", selection: $viewModel.selectedOccasion) {
                ForEach(WishlistCategory.allCases, id: \.self) { occasion in
                    Text(occasion.rawValue.capitalized)
                }
            }
            .pickerStyle(MenuPickerStyle())
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
            navigateToWishlist = true
        }
    }
}

#Preview{
    AddWishGiftView()
}
