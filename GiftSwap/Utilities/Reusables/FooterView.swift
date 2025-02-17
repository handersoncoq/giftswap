//
//  FooterView.swift
//  GiftSwap
//
//  Created by Handerson COQ on 2/7/25.
//

import SwiftUI

func FooterView() -> some View {
    VStack {
        Text("\(NSLocalizedString("app_name", comment: "")) v\(NSLocalizedString("app_version", comment: ""))")
            .font(.caption2)
            .foregroundColor(Color.blackAndWhite.opacity(0.5))
        
        Text("© \(Date().formatted(.dateTime.year())) All rights reserved.")
            .font(.caption2)
            .foregroundColor(Color.blackAndWhite.opacity(0.5))
    }
}

struct FooterView_Previews: PreviewProvider {
    static var previews: some View {
        FooterView()
    }
}
