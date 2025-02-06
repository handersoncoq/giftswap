//
//  ContentView.swift
//  GiftSwap
//
//  Created by Handerson COQ on 1/27/25.
//

import SwiftUI

struct ContentView: View {
    @State private var showHomeView = false

    var body: some View {
        Group {
            if showHomeView {
                HomeView()
                    .transition(.opacity)
            } else {
                VStack {
                    LogoAnimation()
                    Text(LocalizedStringKey("app_name"))
                        .font(.largeTitle)
                        .foregroundColor(Color.white)
                }
                .padding()
                .transition(.opacity)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("App_Primary"))
        .ignoresSafeArea()
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                withAnimation {
                    showHomeView = true
                }
            }
        }
    }
}


#Preview {
    ContentView()
}
