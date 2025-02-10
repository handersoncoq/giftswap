//
//  LoginView.swift
//  GiftSwap
//
//  Created by Handerson COQ on 2/10/25.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                
                Spacer().frame(height: 120)

                // App Logo
                Image("AppLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color("App_Primary"), lineWidth: 5))
                    .padding(.bottom, 40)

                // Email Input
                inputField(icon: "person.fill", placeholder: "Username", text: $viewModel.email, keyboardType: .emailAddress)
                    .padding(.bottom, 10)

                // Password Input
                inputField(icon: "lock.fill", placeholder: "Password", text: $viewModel.password, isSecure: true)

                // Forgot Password
                HStack {
                    Spacer()
                    Button(action: { print("Forgot password tapped") }) {
                        Text("Forgot email or password?")
                            .foregroundColor(Color.blue)
                            .font(.caption)
                    }
                }
                .padding(.top, 5)

                // Error Message
                if let error = viewModel.loginError {
                    Text(error)
                        .foregroundColor(.red)
                        .font(.caption)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top, 5)
                }

                // Login Button
                CTAButton(
                    label: viewModel.isLoading ? "Logging in..." : "Login",
                    backgroundColor: Color("App_Primary"),
                    action: { viewModel.login() },
                    icon: Image(systemName: "arrow.right.circle.fill")
                )
                .padding(.top, 30)
                .disabled(viewModel.isLoading)

                // Join Now
                HStack {
                    Text("Don't have an account?")
                    Button(action: { print("Join now tapped") }) {
                        Text("Join now")
                            .foregroundColor(Color.blue)
                            .bold()
                    }
                }
                .font(.footnote)
                .padding(.top, 20)

                Spacer()
            }
            .padding()
            .navigationDestination(isPresented: $viewModel.isAuthenticated) {
                HomeView()
            }
        }
        .navigationBarBackButtonHidden(true)
    }

    
    private func inputField(icon: String, placeholder: String, text: Binding<String>, keyboardType: UIKeyboardType = .default, isSecure: Bool = false) -> some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(Color("App_Primary"))
                .frame(width: 20)

            if isSecure {
                SecureField(placeholder, text: text)
                    .textContentType(.password)
                    .autocapitalization(.none)
                    .padding(12)
            } else {
                TextField(placeholder, text: text)
                    .keyboardType(keyboardType)
                    .autocapitalization(.none)
                    .padding(12)
            }
        }
        .padding(.horizontal, 12)
        .background(Color("Primary_Neutral").opacity(0.06))
        .cornerRadius(10)
        .frame(height: 50)
    }
}




#Preview {
    LoginView()
}
