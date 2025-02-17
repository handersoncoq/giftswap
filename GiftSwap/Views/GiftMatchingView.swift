//
//  GiftMatchingView.swift
//  GiftSwap
//
//  Created by Handerson COQ on 2/9/25.
//

import SwiftUI
import Combine

struct GiftMatchingView: View {
    @ObservedObject var viewModel = GiftMatchingViewModel()
    @Binding var isPresented: Bool
    @State var isPending = false;
    
    var body: some View {
        VStack{
            VStack(spacing: 20) {
                SheetHandle()
                
                Text("Finding Your Perfect Swap")
                    .font(.title2)
                    .bold()
                    .padding(.top)
                
                headerView()
                
                if let matchedGift = viewModel.selectedGift {
                    NavigationLink(value: matchedGift) {
                        Text("View Matched Gift")
                    }
                }
                
                Text(viewModel.statusText)
                    .font(.body)
                    .foregroundColor(.secondary)
                    .padding(.top, 10)
                
                Spacer()
                
                if viewModel.showCancelButton {
                    cancelButton(action: {
                        isPresented = false
                    }, label: "Cancel")
                }
                
                if viewModel.showMatchResult {
                    if let matchedPair = viewModel.matchedPair {
                        matchFoundView(userGift: matchedPair.0, matchedGift: matchedPair.1)
                    } else {
                        noMatchView()
                    }
                }
            }
            .navigationDestination(for: SwapGift.self) { gift in
                SimpleGiftDetailView(gift: gift, viewModel: SwapBasketViewModel())
            }
            .padding()
            .onAppear {
                viewModel.startMatchingProcess()
            }
            .alert("Your swap request has successfully been sent.", isPresented: $viewModel.showSuccessAlert) {
                Button("OK", role: .cancel) {
                    isPresented = false
                    isPending = false
                }
            }
            FooterView()
        }.overlay(
            isPending ? LoadingOverlayView() : nil
        )
    }

    
    private func headerView() -> some View {
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
    }
    
    private func cancelButton(action: () -> Void, label: String) -> some View {
        VStack {
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
    
    private func matchFoundView(userGift: SwapGift, matchedGift: SwapGift) -> some View {
        VStack {
            Spacer()
            Text("We've found a match!")
                .font(.headline)
                .foregroundColor(Color("App_Primary"))
                .padding(.vertical)
                .padding(.top, -25)
            
            HStack(spacing: 4) {
                VStack {
                    Button(action: {
                        viewModel.matchFound(gift: userGift)
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
                        viewModel.matchFound(gift: matchedGift)
                    }) {
                        SwapGiftCard(gift: matchedGift)
                    }
                }
            }
            .padding(.vertical)
            
            Spacer()
            
            HStack {
                Button(action: {
                    viewModel.showConfirmDialog = true
                }) {
                    Text("Confirm Swap")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.appPrimary)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                
                cancelButton(action: { rejectSwap()
                }, label: "Reject Swap")
            }
            .padding(.top, 45)
            
            Spacer()
        }
        .padding(.vertical)
        .navigationDestination(item: $viewModel.selectedGift) { gift in
            SimpleGiftDetailView(gift: gift, viewModel: SwapBasketViewModel())
        }
        .confirmationDialog(
            "Are you sure you want to confirm this swap?",
            isPresented: $viewModel.showConfirmDialog,
            titleVisibility: .visible
        ) {
            Button("Yes, Confirm") {
                viewModel.confirmSwap(for: userGift)
                isPending = true
            }
            Button("Cancel", role: .destructive) {}
        }
    }
    
    private func noMatchView() -> some View {
        VStack {
            Spacer()
            VStack {
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
    
    func rejectSwap() {
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

