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
                    Spacer()
                    VStack(spacing: 0){
                        content
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .padding(.top, 35)
                    }.background(Color("App_Primary").opacity(0.05)).padding(.top, 10)
                    BottomNav().background(Color("App_Neutral"))
                }
                
                VStack(spacing: 0) {
                    TopNav(isRootView: isRootView, navManager: navigationManager)
                        .frame(maxWidth: .infinity)
                        .background(Color("App_Neutral"))
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            }
            .environmentObject(navigationManager)
        }
    }
}





