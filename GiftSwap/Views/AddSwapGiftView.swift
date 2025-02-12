//
//  AddGiftView.swift
//  GiftSwap
//
//  Created by Handerson COQ on 2/9/25.
//

import SwiftUI
import PhotosUI
import Combine

struct AddSwapGiftView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var imageManager = GiftImageManager()
    @StateObject private var viewModel: SwapGiftFormViewModel
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var navigateToSwapBasket = false


    init() {
        let sharedImageManager = GiftImageManager()
        _imageManager = StateObject(wrappedValue: sharedImageManager)
        _viewModel = StateObject(wrappedValue: SwapGiftFormViewModel(imageManager: sharedImageManager))
    }

    var body: some View {
        MainLayoutView(isRootView: false) {
            VStack(alignment: .leading, spacing: 0) {
                Text("Add a Gift to Your Swap Basket")
                    .font(.largeTitle)
                    .bold()
                    .padding()
                    .padding(.bottom, 20)

                ScrollView(showsIndicators: false) {
                    VStack(spacing: 20) {
                        giftImagesPicker
                        giftInfoFields
                        swapCategoryPicker
                        addGiftButton
                    }
                }
                .padding(.horizontal)
            }
            .alert(alertMessage, isPresented: $showAlert) {
                Button("OK", role: .cancel) {
                    if navigateToSwapBasket {
                        navigateToSwapBasket = true
                    }
                }
            }
            .navigationDestination(isPresented: $navigateToSwapBasket) {
                SwapBasketView()
            }
        }
        .navigationBarBackButtonHidden(true)
    }

    // MARK: - Gift Image Picker
    private var giftImagesPicker: some View {
        GiftImagesPickerView(imageManager: imageManager) 
    }

    // MARK: - Gift Info Fields
    private var giftInfoFields: some View {
        VStack(alignment: .leading, spacing: 0) {
            AppTextField(placeholder: "Gift Name*", text: $viewModel.giftName, characterLimit: 50)
            AppTextField(placeholder: "Gift Description*", text: $viewModel.giftDescription, characterLimit: 250, isMultiline: true)
            AppTextField(placeholder: "Value ($)*", text: $viewModel.giftValue, keyboardType: .decimalPad)
            AppTextField(placeholder: "Store Link (Optional)", text: $viewModel.storeLink)
        }
    }

    // MARK: - Gift Category Picker
    private var swapCategoryPicker: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Category")
                .font(.headline)

            Picker("Select a Category", selection: $viewModel.selectedCategory) {
                ForEach(GiftCategory.allCases, id: \.self) { category in
                    Text(category.rawValue.capitalized)
                }
            }
            .pickerStyle(MenuPickerStyle())
        }.frame(maxWidth: .infinity, alignment: .leading).padding(.top, -22)
    }

    // MARK: - Add Gift Button
    private var addGiftButton: some View {
        VStack {
            CTAButton(
                label: "Add Gift to Swap Basket",
                backgroundColor: Color("App_Primary"),
                action: addGift,
                icon: Image(systemName: "basket")
            )
        }
        .padding(.bottom, 50)
    }

    // MARK: - Add Gift Logic
    private func addGift() {
        let result = viewModel.addGiftToSwapBasket()
        if let errorMessage = result {
            alertMessage = errorMessage
            showAlert = true
        } else {
            alertMessage = "Gift added successfully!"
            showAlert = true
            navigateToSwapBasket = true
        }
    }
}


#Preview{
    AddSwapGiftView()
}
