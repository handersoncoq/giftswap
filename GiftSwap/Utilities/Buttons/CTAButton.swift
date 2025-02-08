//
//  CTAButton.swift
//  GiftSwap
//
//  Created by Handerson COQ on 1/29/25.
//

import SwiftUI

struct CTAButton: View {
    var label: String
    var backgroundColor: Color
    var action: () -> Void
    var icon: Image? = nil

    // ripple states
    @State private var ripplePoint: CGPoint = .zero
    @State private var rippleScale: CGFloat = 0
    @State private var rippleOpacity: Double = 0

    @State private var isPressed: Bool = false

    var body: some View {
        Button(action: {
            action()
            
            let generator = UIImpactFeedbackGenerator(style: .medium)
            generator.impactOccurred()
        }) {
            ZStack {
                // Frame
                Capsule()
                    .fill(backgroundColor)
                
                // Ripple Effect
                Circle()
                    .fill(Color.white.opacity(0.3))
                    .scaleEffect(rippleScale)
                    .opacity(rippleOpacity)
                    .position(ripplePoint)
                    .animation(.easeOut(duration: 0.5), value: rippleScale)
                    .animation(.easeOut(duration: 0.5), value: rippleOpacity)
                
                if let icon = icon {
                    icon
                        .font(.system(size: 35))
                        .foregroundColor(Color.white.opacity(0.2))
                        .offset(x: 158, y: 0)
                }

                // Label
                Text(label)
                    .font(.headline).bold()
                    .foregroundColor(.white)
                    .padding()
            }
            .frame(maxWidth: .infinity)
            .frame(height: 50)
            .clipShape(Capsule())
            .contentShape(Capsule())
            .background(
                GeometryReader { geometry in
                    Color.clear
                        .onAppear {
                            ripplePoint = CGPoint(x: geometry.size.width / 2, y: geometry.size.height / 2)
                        }
                }
            )
            .shadow(color: isPressed ? .clear : Color.black.opacity(0.4), radius: 4, x: 0, y: 4)
        }
        .simultaneousGesture(
            TapGesture()
                .onEnded { _ in
                    rippleScale = 0
                    rippleOpacity = 1
                    withAnimation(.easeOut(duration: 0.5)) {
                        rippleScale = 3
                        rippleOpacity = 0
                    }

                    withAnimation(.easeInOut(duration: 0.3)) {
                        isPressed = true
                    }

                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            isPressed = false
                        }
                    }
                }
        )
    }
}




