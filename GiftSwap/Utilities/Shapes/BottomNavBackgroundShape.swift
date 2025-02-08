//
//  BottomNavBackgroundShape.swift
//  GiftSwap
//
//  Created by Handerson COQ on 2/7/25.
//

import SwiftUI

struct BottomNavBackgroundShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let width = rect.width
        let height = rect.height
        let dipWidth: CGFloat = 80
        let dipHeight: CGFloat = 40
        
        path.move(to: CGPoint(x: 0, y: 0))
        
        path.addLine(to: CGPoint(x: (width / 2) - (dipWidth / 2), y: 0))
        
        path.addQuadCurve(
            to: CGPoint(x: (width / 2) + (dipWidth / 2), y: 0),
            control: CGPoint(x: width / 2, y: -dipHeight)
        )
        
        path.addLine(to: CGPoint(x: width, y: 0))
        path.addLine(to: CGPoint(x: width, y: height))
        path.addLine(to: CGPoint(x: 0, y: height))
        
        path.closeSubpath()
        
        return path
    }
}
