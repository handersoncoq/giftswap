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
                // Background with flowing lines
                ZStack(alignment: .top) {
                    FlowingCurlyLinesView()
                        .frame(height: 120)
                        .padding(.bottom, 10)
                }
                
                // App Logo
                Image("AppLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                    .shadow(radius: 8)
                    .overlay(Circle().stroke(Color("App_Primary"), lineWidth: 5))
                    .padding(.bottom, 40)
                    .padding(.top, 20)

                // Input Fields
                inputField(icon: "person.fill", placeholder: "Username", text: $viewModel.username, keyboardType: .emailAddress)
                    .padding(.bottom, 10)

                inputField(icon: "lock.fill", placeholder: "Password", text: $viewModel.password, isSecure: true)

                // Forgot Password
                HStack {
                    Spacer()
                    Button(action: { print("Forgot password tapped") }) {
                        Text("Forgot username or password?")
                            .foregroundColor(Color.blue)
                            .font(.caption)
                    }
                }
                .padding(.top, 10)


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
                
                // Error Message
                if let error = viewModel.loginError {
                    Text(error)
                        .foregroundColor(.red)
                        .font(.body)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.top)
                }

                Spacer()
                
                FooterView()
                    .padding(.bottom, 10)
            }
            .padding()
            .background(Color("Primary_Neutral").opacity(0.2))
            .navigationDestination(isPresented: $viewModel.isAuthenticated) {
                HomeView()
            }
        }
        .navigationBarBackButtonHidden(true)
    }


    // MARK: - Input Field Component
    private func inputField(icon: String, placeholder: String, text: Binding<String>, keyboardType: UIKeyboardType = .default, isSecure: Bool = false) -> some View {
        ZStack(alignment: .leading) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(Color("App_Primary"))
                    .frame(width: 20)
                    .padding(.leading, 8)

                if text.wrappedValue.isEmpty {
                    Text(placeholder)
                        .foregroundColor(Color.black.opacity(0.5))
                        .padding(.leading, 4)
                }
            }

            HStack {
                Image(systemName: icon)
                    .foregroundColor(Color.clear)
                    .frame(width: 20)
                    .padding(.leading, 8)

                if isSecure {
                    SecureField("", text: text)
                        .textContentType(.password)
                        .autocapitalization(.none)
                        .padding(.vertical, 12)
                        .padding(.leading, 4)
                } else {
                    TextField("", text: text)
                        .keyboardType(keyboardType)
                        .autocapitalization(.none)
                        .padding(.vertical, 12)
                        .padding(.leading, 4)
                }
            }
        }
        .padding(.horizontal, 12)
        .background(Color.white)
        .cornerRadius(10)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color("App_Primary").opacity(0.6), lineWidth: 1)
        )
        .shadow(color: Color.black.opacity(0.08), radius: 12, x: 0, y: 10)
        .frame(height: 50)
    }



}



#Preview {
    LoginView()
}
