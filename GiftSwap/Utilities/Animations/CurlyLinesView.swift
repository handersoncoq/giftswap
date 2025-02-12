//
//  CurlyLinesView.swift
//  GiftSwap
//
//  Created by Handerson COQ on 2/11/25.
//

import SwiftUI

struct FlowingCurlyLinesView: View {
    @State private var animationProgress: CGFloat = 0.0
    
    var body: some View {
        ZStack {
            ForEach(0..<6, id: \.self) { index in
                SproutingCurlyLine(
                    offset: CGFloat(index) * 2,
                    spreadFactor: CGFloat(index) * 4,
                    curlTightness: CGFloat.random(in: 30...50),
                    angleVariation: CGFloat(index) * 2
                )
                .stroke(Color("App_Primary"), style: StrokeStyle(lineWidth: 1, lineCap: .round, lineJoin: .round))
                .opacity(0.6)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
    }
}

struct SproutingCurlyLine: Shape {
    var offset: CGFloat
    var spreadFactor: CGFloat
    var curlTightness: CGFloat
    var angleVariation: CGFloat // Controls the increasing angle between lines
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let startX: CGFloat = -50 // Start off-screen to enter smoothly
        let startY: CGFloat = -50 + offset // Adjust to make entry smooth
        let baseAmplitude: CGFloat = 40
        let waveLength: CGFloat = 60
        let numCurves = 3
        let curlLoops = 3 // Increased for more curls at the tip
        
        path.move(to: CGPoint(x: startX, y: startY))
        
        // Diagonal movement with downward V spreading effect
        var currentX: CGFloat = startX
        var currentY: CGFloat = startY
        
        for i in 0..<numCurves {
            let xOffset = waveLength + spreadFactor * CGFloat(i) * 0.6 // Gradually increases spacing
            let yOffset = 30 + CGFloat(i) * 8 // Moves downward
            
            let control1 = CGPoint(x: currentX + xOffset / 3, y: currentY - baseAmplitude)
            let control2 = CGPoint(x: currentX + 2 * xOffset / 3, y: currentY + baseAmplitude)
            let endPoint = CGPoint(
                x: currentX + xOffset + angleVariation * CGFloat(i), // Spreads outward
                y: currentY + yOffset
            )
            
            path.addCurve(to: endPoint, control1: control1, control2: control2)
            
            currentX = endPoint.x
            currentY = endPoint.y
        }
        
        // Tip curls multiple times
        var curlStart = CGPoint(x: currentX, y: currentY)
        let curlRadius: CGFloat = curlTightness
        
        for _ in 0..<curlLoops {
            let curlCenter = CGPoint(x: curlStart.x + curlRadius, y: curlStart.y + curlRadius)
            let endPoint = CGPoint(x: curlStart.x + 2 * curlRadius, y: curlStart.y)
            
            path.addArc(center: curlCenter, radius: curlRadius, startAngle: .degrees(180), endAngle: .degrees(0), clockwise: false)
            curlStart = endPoint
        }
        
        return path
    }
}

struct ShapeView: View {
    var body: some View {
        FlowingCurlyLinesView()
    }
}

#Preview {
    ShapeView()
}







