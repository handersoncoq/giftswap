//
//  SimpleGiftDetailView.swift
//  GiftSwap
//
//  Created by Handerson COQ on 2/13/25.
//

import SwiftUI
import Combine


struct SimpleGiftDetailView: View {
    let gift: SwapGift
    @ObservedObject var viewModel: SwapBasketViewModel
    @State private var currentIndex: Int = 0
    @State private var showConfirmation = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var giftOwner: String = "Loading..."

    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        
            ScrollView {
                VStack(alignment: .leading, spacing: 14) {
                    SimpleGiftImageCarousel(gift: gift, currentIndex: $currentIndex)
                    SimpleGiftDetails(gift: gift)
                    
                    VStack(alignment: .leading) {
                        HStack(spacing: 25){
                        SwapStatusView(status: gift.swapStatus)
                        VStack(alignment: .leading) {
                            HStack {
                                Image(systemName: "person.fill").foregroundColor(.appPrimary).padding(.top, -3)
                                Text("@\(giftOwner)")
                                    .font(.caption)
                                    .foregroundColor(Color.secondary)
                            }
                        }}
                    }
                    .onAppear {
                        viewModel.getGiftOwner(gift: gift) { ownerName in
                            giftOwner = ownerName
                        }
                    }

                   
                }
                .padding()
            }.padding(.vertical, 45).background(Color.appPrimary.opacity(0.05))
            .alert(alertMessage, isPresented: $showAlert) {
                Button("OK", role: .cancel) { }
            }
        
    }


}

// get gift's owner


// Gift Images
struct SimpleGiftImageCarousel: View {
    let gift: SwapGift
    @Binding var currentIndex: Int

    var body: some View {
        if let images = gift.imageURLs, !images.isEmpty {
            ZStack {
                TabView(selection: $currentIndex) {
                    ForEach(images.indices, id: \.self) { index in
                        AsyncImage(url: URL(string: images[index])) { phase in
                            switch phase {
                            case .empty:
                                ProgressView().frame(height: 300)
                            case .success(let image):
                                image.resizable().frame(maxWidth: 450, maxHeight: 270).cornerRadius(16)
                            case .failure:
                                SimpleSimpleSimpleGiftImageCarousel().frame(height: 300)
                            @unknown default:
                                EmptyView()
                            }
                        }
                        .tag(index)
                    }
                }
                .frame(height: 270)
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))

                // Image Indicator
                if images.count >= 1 {
                    Text("\(currentIndex + 1)/\(images.count)")
                        .font(.body)
                        .foregroundColor(Color("App_Primary"))
                        .frame(maxWidth: .infinity, alignment: .center)
                        .offset(y: 152)
                }
            }
            .padding(.bottom, 30)
        } else {
            SimpleSimpleSimpleGiftImageCarousel().frame(height: 300)
        }
    }
}

// Gift Details
struct SimpleGiftDetails: View {
    let gift: SwapGift

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(gift.name)
                .font(.largeTitle)
                .bold()

            Text(gift.description)
                .font(.body)

            Text("Category: \(gift.category.rawValue.capitalized)")
                .font(.caption)
                .foregroundColor(.secondary)

            HStack(spacing: 18) {
                Text("Value: $\(gift.value, specifier: "%.2f")")
                    .font(.body)
                    .foregroundColor(Color.blue)

                if let storeLink = gift.storeLink, let url = URL(string: storeLink) {
                    Link(destination: url) {
                        Image(systemName: "link")
                    }
                }
            }
        }
    }
}

// Placeholder Image
struct SimpleSimpleSimpleGiftImageCarousel: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 16)
            .fill(Color.white)
            .frame(height: 300)
            .overlay(
                Image(systemName: "gift.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .foregroundColor(Color("App_Primary"))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color("App_Primary"), lineWidth: 1)
            )
            .shadow(radius: 4)
    }
}




// Preview
struct SimpleGiftDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SimpleGiftDetailView(gift: MockSwapGifts.gifts[0], viewModel: SwapBasketViewModel())
        }
    }
}
