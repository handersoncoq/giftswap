//
//  BottomNavBar.swift
//  GiftSwap
//
//  Created by Handerson COQ on 2/7/25.
//

import SwiftUI

struct BottomNav: View {
    @State private var navigateToSwapBasket = false
    @State private var showGiftMatching = false
    @State private var isAnimating = false

    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                BottomNavBackgroundShape()
                    .fill(Color("App_Neutral").opacity(0.95))
                    .frame(height: 80)
                    .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: -6)

                HStack {
                    BottomNavItem(icon: "basket", label: "My Basket") {
                        navigateToSwapBasket = true
                    }
                    BottomNavItem(icon: "waveform.path.ecg", label: "History") {
                        print("History")
                    }

                    swapButton

                    BottomNavItem(icon: "heart", label: "Wishlist") {
                        print("Wishlist")
                    }
                    BottomNavItem(icon: "person.2", label: "Friends") {
                        print("Friends")
                    }
                }
                .padding(.horizontal, 10)
                .background(Color("App_Neutral").opacity(0.95))
            }
        }
        .navigationDestination(isPresented: $navigateToSwapBasket) {
            SwapBasketView()
        }
        .sheet(isPresented: $showGiftMatching) {
            GiftMatchingView(isPresented: $showGiftMatching)
        }
    }

    private var swapButton: some View {
        ZStack {
            Circle()
                .frame(width: 72, height: 72)
                .foregroundColor(Color("App_Primary"))
                .shadow(radius: 6, x: 0, y: 5)

            Button(action: {
                isAnimating = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                    isAnimating = false
                    showGiftMatching = true
                }
            }) {
                Image(systemName: "arrow.2.circlepath")
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(.white)
                    .rotationEffect(.degrees(isAnimating ? 360 : 0)) // Animation
                    .animation(.easeInOut(duration: 0.6), value: isAnimating)
                    .frame(width: 60, height: 60)
                    .background(Color("App_Primary"))
                    .clipShape(Circle())
            }
        }
        .offset(y: -12)
    }
}





struct BottomNav_Previews: PreviewProvider {
    static var previews: some View {
        BottomNav()
    }
}
