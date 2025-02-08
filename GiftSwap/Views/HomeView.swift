//
//  HomeView.swift
//  GiftSwap
//
//  Created by Handerson COQ on 1/28/25.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        MainLayoutView(isRootView: true) {
            ZStack {
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        
                        // Sections
                        headerSection
                        ctaButtonSection
                        dividerSection
                        exploreSection
                        
                        // Marketplace View
                        MarketplaceView()
                        
                        // partner gifts
                        partnerSection
                        
                        // Footnote
                        footnoteSection
                    }
                    .padding(.vertical, 18)
                    .ignoresSafeArea()
                }
            }
        }.navigationBarBackButtonHidden(true)
    }
        
}


// MARK: - Subviews

private var headerSection: some View {
    HStack {
        VStack(alignment: .leading, spacing: 8) {
            Text("Just Swap It!")
                .font(.largeTitle)
                .bold()
            Text(LocalizedStringKey("app_name"))
                .font(.title2)
                .foregroundColor(Color("App_Primary"))
        }
        Spacer()
        UserIcon()
    }
    .padding(.horizontal)
    .padding(.vertical)
}

private var ctaButtonSection: some View {
    VStack {
        Text("Got a gift that’s not quite right? Add it to your basket, and we’ll find the perfect swap for you!")
            .font(.body)
            .padding(.horizontal)
        
        CTAButton(
            label: "Add Gifts to Your Swap Basket Now!",
            backgroundColor: Color("App_Primary"),
            action: {
                print("Add Gift!")
            },
            icon: Image(systemName: "basket")
        )
        .padding(.horizontal)
    }
}

private var dividerSection: some View {
    HStack {
        Rectangle()
            .frame(height: 1)
        Text("OR")
            .font(.headline)
        Rectangle()
            .frame(height: 1)
    }
    .padding(.horizontal)
    .padding(.vertical)
}

private var exploreSection: some View {
    VStack(alignment: .leading, spacing: 8) {
        Text("Explore The Marketplace")
            .font(.title2)
            .bold()
        
        Text("Find a gift that you love and request a swap.")
            .font(.body) +
        Text("¹")
            .font(.footnote)
            .baselineOffset(6)
            .foregroundColor(Color("App_Primary"))
    }
    .padding(.horizontal)
}

private var partnerSection: some View {
    VStack(alignment: .leading, spacing: 8) {
        Text("Curated Gift Picks for Your Wishlist")
            .font(.title2)
            .bold()
        
        HStack {
            Text("Explore our thoughtfully curated selection of gifts and add your favorites to your wishlist. Make it easy for your partner to choose something special just for you!")
                .font(.body)
                .opacity(0.75)
            
            Spacer()
            
            NavigationLink(destination: CuratedGifts()){
                    Image(systemName: "arrow.right")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                        .foregroundColor(Color("App_Primary"))
                        .padding(20)
                    
                }}
        }.padding(.horizontal)
    }

private var footnoteSection: some View {
    (Text("¹")
        .font(.footnote)
        .baselineOffset(6)
        .foregroundColor(Color("App_Primary")) +
     Text("Note: Gifts can only be swapped if both parties agree.")
        .font(.footnote)
        .foregroundColor(.secondary))
    .padding(.horizontal)
    .padding(.vertical, 30)
}

    
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
