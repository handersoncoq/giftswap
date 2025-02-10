//
//  ContentView.swift
//  GiftSwap
//
//  Created by Handerson COQ on 1/27/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject var navManager = NavigationManager()
    @AppStorage("isAuthenticated") private var isAuthenticated: Bool = false
    @State private var showMainView = false

    var body: some View {
        Group {
            if showMainView {
                if isAuthenticated {
                    HomeView()
                        .transition(.opacity)
                        .environmentObject(navManager)
                } else {
                    LoginView()
                        .transition(.opacity)
                }
            } else {
                splashScreenView
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("App_Primary"))
        .ignoresSafeArea()
        .onAppear {
            scheduleMainViewTransition()
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

    private func scheduleMainViewTransition() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            withAnimation {
                if UserDefaults.standard.bool(forKey: "isAuthenticated") {
                    isAuthenticated = true
                }
                showMainView = true
            }
        }
    }

}


#Preview {
    ContentView()
}
