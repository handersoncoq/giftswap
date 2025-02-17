//
//  LoadingOverlay.swift
//  GiftSwap
//
//  Created by Handerson COQ on 2/17/25.
//

import SwiftUI

struct LoadingOverlayView: View {
    var body: some View {
        ZStack {
            Color.black.opacity(0.6)
                .edgesIgnoringSafeArea(.all)

            VStack(spacing: 30) {
                Text("Sending your request...")
                    .font(.caption)
                    .foregroundColor(.white)
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .appPrimary))
                    .scaleEffect(1.5)
            }
        }
    }
}
