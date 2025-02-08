//
//  FooterView.swift
//  GiftSwap
//
//  Created by Handerson COQ on 2/7/25.
//

import SwiftUI

struct FooterView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            // App Name
            Text("GiftSwap®")
                .font(.headline)
                .bold()
                .foregroundColor(Color("App_Primary"))

            // Footer Links
            VStack(alignment: .leading, spacing: 4) {
                Button(action: { print("Customer Service")}) {
                    Text("Customer Service")
                }
                Button(action: { print("Partnership") }) {
                    Text("Partnership")
                }
                Button(action: { print("Contacts") }) {
                    Text("Contacts")
                }
            }
            .foregroundColor(.white)
            .font(.footnote)
            .padding(.vertical, 8)

            // Legal Links
            HStack {
                Button(action: {  print("Cookie Policy")}) {
                    Text("Cookie Policy")
                }
                Text("|")
                Button(action: { print("Privacy Policy")}) {
                    Text("Privacy Policy")
                }
                Text("|")
                Button(action: { print("User Terms")}) {
                    Text("User Terms")
                }
                Text("|")
                Button(action: { print("About")}) {
                    Text("About")
                }
            }
            .font(.footnote)
            .foregroundColor(Color("App_Primary"))
            .padding(.vertical, 8)

            // Copyright Text
            Text("@2025 GiftSwap. All Rights Reserved")
                .font(.caption2)
                .foregroundColor(.white.opacity(0.8))
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.bottom, 16)
        }
        .padding()
        .background(Color.black)
    }
}

struct FooterView_Previews: PreviewProvider {
    static var previews: some View {
        FooterView()
    }
}
