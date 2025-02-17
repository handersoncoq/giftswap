//
//  SecondaryButton.swift
//  GiftSwap
//
//  Created by Handerson COQ on 2/12/25.
//

import SwiftUI

struct SecondaryButton: View {
    var action: () -> Void
    var label: String
    var isLoading: Bool = false
    var backgroundColor: Color = Color("App_Primary")
    var foregroundColor: Color = .white
    
    var body: some View {
        Button(action: action) {
            HStack {
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle(tint: .white))
                }
                Text(isLoading ? "Fetching..." : label)
                    .foregroundColor(foregroundColor)
                    .fontWeight(.medium)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(backgroundColor)
            .cornerRadius(10)
        }
    }
}
