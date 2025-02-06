//
//  LogoAnimation.swift
//  GiftSwap
//
//  Created by Handerson COQ on 1/28/25.
//

import SwiftUI

struct LogoAnimation: View {
    @State private var phase: CGFloat = 0.0

    var body: some View {
        GiftSwapShape()
            .trim(from: 0, to: phase)
            .stroke(Color.white, style: StrokeStyle(lineCap: .round))
            .frame(width: 120, height: 100)
            .onAppear {
                withAnimation(.linear(duration: 5)) {
                    phase = 1.0
                }
            }
    }

}
