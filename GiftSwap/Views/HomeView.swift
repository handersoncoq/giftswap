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
            NavigationView {
                ZStack {
                    Color("Background").opacity(0.4)
                    ScrollView {
                        VStack(alignment: .leading, spacing: 20) {
                            
                            // Header
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
                            
                            // CTA Button
                            Text("Got a gift that’s not quite right? Add it to your basket, and we’ll find the perfect swap for you!").font(.body).padding(.horizontal)
                            CTAButton(
                                label: "Add Gifts to Your Swap Basket Now!",
                                backgroundColor: Color("App_Primary"),
                                action: {
                                    print("Add Gift!")
                                },
                                icon: Image(systemName: "basket")
                            ).padding(.horizontal)
                            
                            // Divider with "OR"
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
                            
                            // Explore Section
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Explore The Marketplace")
                                    .font(.title2)
                                    .bold()
                                
                                
                                Text("Find a gift that you love and request a swap.")
                                    .font(.body) +
                                Text("¹")
                                    .font(.footnote)
                                    .baselineOffset(6).foregroundColor(Color("App_Primary"))
                            }
                            .padding(.horizontal)
                            
                            MarketplaceView()
                            
                            (Text("¹")
                                .font(.footnote)
                                .baselineOffset(6)
                                .foregroundColor(Color("App_Primary")) +
                             Text("Note: Gifts can only be swapped if both parties agree.")
                                .font(.footnote)
                                .foregroundColor(.secondary))
                            .padding(.horizontal)
                            .padding(.vertical, 20)
                        }
                        .padding(.vertical, 18)
                        .ignoresSafeArea()
                    }
                    
                }
                
            }
        }
    }
}



struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
