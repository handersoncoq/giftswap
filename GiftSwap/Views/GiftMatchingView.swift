//
//  GiftMatchingView.swift
//  GiftSwap
//
//  Created by Handerson COQ on 2/9/25.
//

import SwiftUI
import Combine

struct GiftMatchingView: View {
    @ObservedObject var authService = AuthService.shared
    @Binding var isPresented: Bool
    @State private var statusText: String = "Looking into your swap basket..."
    @State private var showMatchResult = false
    @State private var matchedPair: (SwapGift, SwapGift)?
    @State private var cancellables = Set<AnyCancellable>()
    @State private var navigateToSwapGiftDetail = false
    @State private var selectedGift: SwapGift?
    @State private var showCancelButton = true
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Finding Your Perfect Swap")
                .font(.title2)
                .bold()
                .padding(.top)
            
            // Matching Animation
            HStack {
                Image(systemName: "gift.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .foregroundColor(Color("App_Primary"))
                
                DotsLoadingAnimation()
                
                Image(systemName: "gift.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                    .foregroundColor(Color("App_Primary"))
            }
            
            if let matchedGift = selectedGift {
                NavigationLink(value: matchedGift) {
                    Text("View Matched Gift")
                }
            }

            
            // Status Updates
            Text(statusText)
                .font(.body)
                .foregroundColor(.secondary)
                .padding(.top, 10)
            
            Spacer()
            
            if showCancelButton {
                cancelButton(action: {
                    isPresented = false
                }, label: "Cancel")
            }
            
            
            if showMatchResult {
                if let matchedPair = matchedPair {
                    matchFoundView(userGift: matchedPair.0, matchedGift: matchedPair.1)
                } else {
                    noMatchView()
                }
            }
        }.navigationDestination(for: SwapGift.self) { gift in
            SimpleGiftDetailView(gift: gift, viewModel: SwapBasketViewModel())
        }

        .padding()
        .onAppear {
            startMatchingProcess()
        }
        FooterView()
    }
    
    
    private func startMatchingProcess() {
        guard let currentUser = authService.currentUser else {
            print("No logged-in user")
            return
        }
        
        // Simulating the status updates
        let statuses = [
            "Looking into your swap basket...",
            "Checking your wishlist...",
            "Searching the marketplace..."
        ]
        
        for (index, text) in statuses.enumerated() {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(index + 1)) {
                statusText = text
            }
        }
        
        // Simulating matching result after 4 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            GiftMatchingService.shared.startMatchingProcess(for: currentUser.id)
                .sink(receiveCompletion: { _ in }, receiveValue: { matchedPair in
                    self.matchedPair = matchedPair
                    self.showMatchResult = true
                    self.showCancelButton = false
                })
                .store(in: &cancellables)
        }
    }
    
    
    private func matchFoundView(userGift: SwapGift, matchedGift: SwapGift) -> some View {
        VStack {
            Spacer()
            Text("We've found a match!")
                .font(.headline)
                .foregroundColor(Color("App_Primary"))
                .padding(.vertical)
                .padding(.top, -25)
            
            // Gifts Displayed Side by Side
            HStack(spacing: 4) {
                VStack {
                    Button(action: {
                        selectedGift = userGift
                        navigateToSwapGiftDetail = true
                    }) {
                        SwapGiftCard(gift: userGift)
                    }
                }
                
                VStack {
                    Image(systemName: "arrow.right")
                        .font(.body)
                        .foregroundColor(Color.appPrimary)
                    Image(systemName: "arrow.left")
                        .font(.body)
                        .foregroundColor(Color.appPrimary)
                }
                
                VStack {
                    Button(action: {
                        selectedGift = matchedGift
                        navigateToSwapGiftDetail = true
                    }) {
                        SwapGiftCard(gift: matchedGift)
                    }
                }
            }
            .padding(.vertical)
            
            Spacer()
            
            HStack {
                Button(action: { confirmSwap(for: matchedGift) }) {
                    Text("Confirm Swap")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.appPrimary)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                
                cancelButton(action: { rejectSwap() }, label: "Reject Swap")
            }
            .padding(.top, 45)
            
            Spacer()
        }
        .padding(.vertical)
        .navigationDestination(item: $selectedGift) { gift in
            SimpleGiftDetailView(gift: gift, viewModel: SwapBasketViewModel())
        }
    }
    
    
    private func matchFound(gift: SwapGift) {
        selectedGift = gift
        navigateToSwapGiftDetail = true
        isPresented = false
    }
    
    
    private func cancelButton(action: () -> Void, label: String) -> some View {
        VStack{
            Button(action: { rejectSwap() }) {
                Text(label)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
    }
    
    
    private func noMatchView() -> some View {
        VStack {
            Spacer()
            VStack{
                Text("Sorry, no match found at this time.")
                    .font(.body)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                Image(systemName: "xmark.circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 23, height: 23)
                    .foregroundColor(Color.red.opacity(0.6))
            }.padding(.top, -25)
            Spacer()
            
            Button(action: { isPresented = false }) {
                Text("Dismiss")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }.padding(.bottom)
        }
    }
    
    private func confirmSwap(for gift: SwapGift) {
        // Update swap status to pending
        SwapBasketService.shared.updateSwapStatus(for: gift.id, to: .pending)
        
        // Notify the other user
        NotificationService.shared.sendNotification(
            to: gift.ownerId,
            message: "You have received a swap request for '\(gift.name)'. Please review the request."
        )
        
        // Dismiss the sheet
        isPresented = false
    }
    
    private func rejectSwap() {
        isPresented = false
    }
}

// Placeholder animation
struct DotsLoadingAnimation: View {
    @State private var offsetX: CGFloat = -3
    
    var body: some View {
        HStack(spacing: 8) {
            Circle()
                .frame(width: 8, height: 8)
                .foregroundColor(.gray).opacity(0.3)
                .offset(x: offsetX)
            Circle()
                .frame(width: 8, height: 8)
                .foregroundColor(.gray).opacity(0.3)
            Circle()
                .frame(width: 8, height: 8)
                .foregroundColor(.gray).opacity(0.3)
                .offset(x: -offsetX)
        }
        .onAppear {
            withAnimation(Animation.easeInOut(duration: 0.8).repeatForever(autoreverses: true)) {
                offsetX = 3
            }
        }
    }
}


#Preview {
    GiftMatchingView(isPresented: .constant(true))
}

