//
//  TopNav.swift
//  GiftSwap
//
//  Created by Handerson COQ on 1/28/25.
//

import SwiftUI

struct TopNav: View {
    var isRootView: Bool
    @Environment(\.dismiss) var dismiss
    @Environment(\.horizontalSizeClass) var sizeClass
    @ObservedObject var navManager: NavigationManager

    var body: some View {
        VStack {
            HStack {
                if isRootView {
                    GiftSwapShape()
                        .stroke(Color("App_Primary"), style: StrokeStyle(lineCap: .round))
                        .frame(width: 44, height: 40)
                } else {
                    backButton
                }

                Spacer()

                navigationButtons
            }
            .padding(.horizontal)
            .padding(.top, 10)
            .padding(.bottom, 15)
        }
    }

    private var backButton: some View {
        Group {
            if sizeClass == .compact {
                Button(action: { dismiss() }) {
                    HStack {
                        Image(systemName: "arrow.left")
                        Text("Back")
                    }
                    .foregroundColor(.blue)
                }
            }
        }
    }

    private var navigationButtons: some View {
        HStack(spacing: 16) {
            if !isRootView {
                homeButton
            }

            notificationButton

            menuButton
        }
    }

    private var homeButton: some View {
        NavigationLink(
            destination: HomeView()
                .navigationBarBackButtonHidden(true),
            label: {
                Image(systemName: "house")
                    .foregroundColor(.primary)
            }
        )
        .simultaneousGesture(TapGesture().onEnded {
            navManager.popToRoot()
        })
    }

    private var notificationButton: some View {
        Button(action: { print("Notifications") }) {
            Image(systemName: "bell")
                .foregroundColor(.primary)
        }
    }

    private var menuButton: some View {
        Button(action: { print("Menu") }) {
            Image(systemName: "line.3.horizontal.decrease")
                .foregroundColor(.primary)
        }
    }
}






