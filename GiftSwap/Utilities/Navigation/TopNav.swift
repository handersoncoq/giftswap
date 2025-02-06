//
//  TopNav.swift
//  GiftSwap
//
//  Created by Handerson COQ on 1/28/25.
//

import SwiftUI

struct TopNav: ToolbarContent {
    var isRootView: Bool

    var body: some ToolbarContent {
        ToolbarItemGroup(placement: .navigationBarLeading) {
            if isRootView {
                VStack {
                    GiftSwapShape()
                        .stroke(Color("App_Primary"), style: StrokeStyle(lineCap: .round))
                        .frame(width: 44, height: 40)
                }
                .padding(.vertical)
            }
        }
        
        ToolbarItemGroup(placement: .navigationBarTrailing) {
            HStack(spacing: 16) {
                Button(action: {
                    print("Notifications")
                }) {
                    Image(systemName: "bell")
                        .foregroundColor(.primary)
                }
                
                Button(action: {
                    print("Menu")
                }) {
                    Image(systemName: "line.3.horizontal.decrease")
                        .foregroundColor(.primary)
                }
            }
            .padding(.vertical)
        }
    }
}
