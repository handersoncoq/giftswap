//
//  GiftMatchingView.swift
//  GiftSwap
//
//  Created by Handerson COQ on 2/9/25.
//

import SwiftUI
import Combine

struct GiftMatchingView: View {
    @Binding var isPresented: Bool
    @State private var statusText: String = "Looking into your swap basket..."
    @State private var showMatchResult = false
    @State private var matchedGift: Gift?
    @State private var cancellables = Set<AnyCancellable>()
    
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
            
            // Status Updates
            Text(statusText)
                .font(.body)
                .foregroundColor(.secondary)
                .padding(.top, 10)
            
            Spacer()
            
            if showMatchResult {
                if let gift = matchedGift {
                    matchFoundView(gift: gift)
                } else {
                    noMatchView()
                }
            }
        }
        .padding()
        .onAppear {
            startMatchingProcess()
        }
    }
    
    private func startMatchingProcess() {
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
            GiftMatchingService.shared.startMatchingProcess(for: UUID())
                .sink(receiveCompletion: { _ in }, receiveValue: { matchedGift in
                    self.matchedGift = matchedGift
                    self.showMatchResult = true
                })
                .store(in: &cancellables)
        }
    }
    
    private func matchFoundView(gift: Gift) -> some View {
        VStack {
            Text("Match Found!")
                .font(.headline)
                .foregroundColor(Color("App_Primary"))
            
            SwapGiftDetailView(gift: gift, viewModel: SwapBasketViewModel())
                .frame(height: 250)

            HStack {
                Button(action: { confirmSwap(for: gift) }) {
                    Text("Confirm Swap")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                
                Button(action: { rejectSwap() }) {
                    Text("Reject Swap")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
        }
    }
    
    private func noMatchView() -> some View {
        VStack {
            Text("Sorry, no matches found at this time.")
                .font(.body)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding()
            
            Button(action: { isPresented = false }) {
                Text("Dismiss")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
        }
    }
    
    private func confirmSwap(for gift: Gift) {
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
    @State private var isAnimating = false
    
    var body: some View {
        HStack {
            Circle().frame(width: 8, height: 8).foregroundColor(.gray)
            Circle().frame(width: 8, height: 8).foregroundColor(.gray)
            Circle().frame(width: 8, height: 8).foregroundColor(.gray)
        }
        .opacity(isAnimating ? 1 : 0.3)
        .animation(Animation.easeInOut(duration: 0.8).repeatForever(), value: isAnimating)
        .onAppear {
            isAnimating = true
        }
    }
}
