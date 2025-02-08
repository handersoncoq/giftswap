//
//  CuratedGifts.swift
//  GiftSwap
//
//  Created by Handerson COQ on 2/7/25.
//

import SwiftUI

struct CuratedGifts: View {
    var body: some View {
        MainLayoutView(isRootView: false) {
            ScrollView{
                VStack(alignment: .leading, spacing: 14){
                    
                    
                    // header section
                    headerSection
                    
                    //TODO: Curated gift list
                    MarketplaceView()
                    
                    Spacer()
                }
            }.padding(.top, 30)
        }.navigationBarBackButtonHidden(true)
    }
}

// header

private var headerSection: some View {
    VStack(alignment: .leading, spacing: 8) {
        Text("Curated Gift Picks for Your Wishlist")
            .font(.largeTitle)
            .bold()
        
        HStack {
            Text("Explore our thoughtfully curated selection of gifts and add your favorites to your wishlist. Make it easy for your partner to choose something special just for you!")
                .font(.body)
        }
    }
    .padding(.horizontal)
}

#Preview {
    CuratedGifts()
}
