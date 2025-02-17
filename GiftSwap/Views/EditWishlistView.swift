//
//  EditWishlistView.swift
//  GiftSwap
//
//  Created by Handerson COQ on 2/11/25.
//

import SwiftUI

struct EditWishlistView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var viewModel: EditWishlistViewModel
    @State private var showAlert = false
    @State private var alertMessage = ""

    init(wishlist: Wishlist) {
        _viewModel = StateObject(wrappedValue: EditWishlistViewModel(wishlist: wishlist))
    }

    var body: some View {
        MainLayoutView(isRootView: false) {
            VStack(alignment: .leading) {
                Text("Edit Wishlist")
                    .font(.largeTitle)
                    .bold()

                AppTextField(placeholder: "Wishlist Name*", text: $viewModel.name)

                AppTextField(placeholder: "Description*", text: $viewModel.description, isMultiline: true)

                Toggle(isOn: $viewModel.isPrivate) {
                    Text("Private Wishlist")
                        .font(.headline)
                }.tint(Color("App_Primary"))
                
                VStack(alignment: .leading, spacing: 0){
                    Text("Category")
                    Picker("Category", selection: $viewModel.selectedCategory) {
                        ForEach(WishlistCategory.allCases, id: \.self) { category in
                            Text(category.rawValue.capitalized).tag(category)
                        }
                    }.padding(.horizontal, -10).pickerStyle(MenuPickerStyle())
                }.padding(.vertical)


                HStack {
                    SecondaryButton(
                        action: { presentationMode.wrappedValue.dismiss() },
                        label: "Cancel",
                        backgroundColor: Color.gray.opacity(0.4),
                        foregroundColor: Color.blue
                    )
                    
                    SecondaryButton(
                        action: saveChanges,
                        label: "Save Changes"
                    )
                }
            }
            .navigationBarBackButtonHidden(true)
            .padding(.horizontal)
            .padding(.top, -50)
            .alert(alertMessage, isPresented: $showAlert) {
                Button("OK", role: .cancel) { }
            }
        }
    }

    private func saveChanges() {
        if let errorMessage = viewModel.saveWishlist() {
            alertMessage = errorMessage
            showAlert = true
        } else {
            presentationMode.wrappedValue.dismiss()
        }
    }
}

// Preview
#Preview {
    EditWishlistView(wishlist: Wishlist(
        userId: MockUsers.initializedUsers[1].id,
        name: "My Christmas Wishlist",
        description: "My dream Christmas gifts!",
        isPrivate: true,
        isActive: true,
        category: .christmas,
        addedAt: Date()
    ))
}
