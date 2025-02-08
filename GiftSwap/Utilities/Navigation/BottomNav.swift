//
//  BottomNavBar.swift
//  GiftSwap
//
//  Created by Handerson COQ on 2/7/25.
//

import SwiftUI

struct BottomNav: View {
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                
                BottomNavBackgroundShape()
                    .fill(Color("App_Neutral").opacity(0.95))
                    .frame(height: 80)
                    .shadow(color: Color.black.opacity(0.2), radius: 4, x: 0, y: -6)
                
                
                HStack {
                    NavItem(icon: "basket", label: "My Basket"){ print("My Basket")}
                    NavItem(icon: "waveform.path.ecg", label: "History"){ print("History")}
                    
                    ZStack {
                        Circle()
                            .frame(width: 72, height: 72)
                            .foregroundColor(Color("App_Primary"))
                            .shadow(radius: 6, x: 0, y: 5)
                        
                        Button(action: {
                            print("Swap Gift")
                        }) {
                            Image(systemName: "arrow.2.circlepath")
                                .font(.system(size: 32, weight: .bold))
                                .foregroundColor(.white)
                                .frame(width: 60, height: 60)
                                .background(Color("App_Primary"))
                                .clipShape(Circle())
                        }
                    }
                    .offset(y: -12)
                    
                    NavItem(icon: "heart", label: "Wishlist"){ print("Wishlist")}
                    NavItem(icon: "person.2", label: "Friends"){ print("Friends")}
                }
                .padding(.horizontal, 10)
                .background(Color("App_Neutral").opacity(0.95))
            }
        }
    }
}



struct BottomNav_Previews: PreviewProvider {
    static var previews: some View {
        BottomNav()
    }
}
