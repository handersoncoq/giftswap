//
//  NavItem.swift
//  GiftSwap
//
//  Created by Handerson COQ on 2/7/25.
//

import SwiftUI

struct NavItem: View {
    let icon: String
    let label: String
    let action: () -> Void
    
    var body: some View {
        VStack {
            Button(action: action) {
                Image(systemName: icon)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 28, height: 28)
                    .foregroundColor(Color("App_Primary"))
            }
            
            Text(label)
                .font(.footnote)
        }
        .frame(maxWidth: .infinity)
    }
}
