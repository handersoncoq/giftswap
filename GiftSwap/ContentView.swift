//
//  ContentView.swift
//  GiftSwap
//
//  Created by Handerson COQ on 1/27/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject var navManager = NavigationManager()
    @State private var showHomeView = false

    var body: some View {
        Group {
            if showHomeView {
                HomeView()
                    .transition(.opacity)
                    .environmentObject(navManager)
            } else {
                splashScreenView
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("App_Primary"))
        .ignoresSafeArea()
        .onAppear {
            scheduleHomeViewTransition()
        }
    }

    private var splashScreenView: some View {
        VStack {
            LogoAnimation()
            Text(LocalizedStringKey("app_name"))
                .font(.largeTitle)
                .foregroundColor(Color.white)
        }
        .padding()
        .transition(.opacity)
    }

    private func scheduleHomeViewTransition() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            withAnimation {
                showHomeView = true
            }
        }
    }
}



#Preview {
    ContentView()
}
