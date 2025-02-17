//
//  SheetHandle.swift
//  GiftSwap
//
//  Created by Handerson COQ on 2/15/25.
//

import SwiftUI

func SheetHandle() -> some View {
    VStack{
        RoundedRectangle(cornerRadius: 3)
            .frame(width: 40, height: 5)
            .foregroundColor(Color.gray.opacity(0.5))
            .padding(.top, 8)
    }
}
