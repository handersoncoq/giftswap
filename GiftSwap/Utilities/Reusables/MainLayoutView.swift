//
//  MainLayoutView.swift
//  GiftSwap
//
//  Created by Handerson COQ on 2/7/25.
//

import SwiftUI

struct MainLayoutView<Content: View>: View {
    var isRootView: Bool
    let content: Content
    @StateObject private var navigationManager = NavigationManager()

    init(isRootView: Bool, @ViewBuilder content: () -> Content) {
        self.isRootView = isRootView
        self.content = content()
    }

    var body: some View {
        NavigationStack(path: $navigationManager.path) {
            ZStack(alignment: .top) {
                Spacer()
                VStack(spacing: 0) {
                    content
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .padding(.top, 35)
                    BottomNav()
                }
                
                VStack(spacing: 0) {
                    TopNav(isRootView: isRootView)
                        .frame(maxWidth: .infinity)
                        .background(Color("App_Neutral").opacity(0.95))
                        .padding(.bottom, 15)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            }
            .environmentObject(navigationManager)
        }
    }
}




