//
//  TopNav.swift
//  GiftSwap
//
//  Created by Handerson COQ on 1/28/25.
//

import SwiftUI

import SwiftUI

struct TopNav: View {
    var isRootView: Bool
    @Environment(\.dismiss) var dismiss
    @Environment(\.horizontalSizeClass) var sizeClass

    var body: some View {
        VStack {
            HStack {
                if isRootView {
                    Button(action: {
                        // Navigate to Home
                    }) {
                        GiftSwapShape()
                            .stroke(Color("App_Primary"), style: StrokeStyle(lineCap: .round))
                            .frame(width: 44, height: 40)
                    }
                } else {
                    if sizeClass == .compact {
                        Button(action: {
                            dismiss()
                        }) {
                            HStack {
                                Image(systemName: "arrow.left")
                                Text("Back")
                            }
                            .foregroundColor(.blue)
                        }
                    }
                }
                
                Spacer()

                HStack(spacing: 16) {
                    Button(action: { print("Notifications") }) {
                        Image(systemName: "bell")
                            .foregroundColor(.primary)
                    }

                    Button(action: { print("Menu") }) {
                        Image(systemName: "line.3.horizontal.decrease")
                            .foregroundColor(.primary)
                    }
                }
            }
            .padding(.horizontal)
            .padding(.vertical, 10)
        }
    }
}



