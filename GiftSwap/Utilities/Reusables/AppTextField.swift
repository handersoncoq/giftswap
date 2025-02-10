//
//  AppTextField.swift
//  GiftSwap
//
//  Created by Handerson COQ on 2/9/25.
//

import SwiftUI

struct AppTextField: View {
    let placeholder: String
    @Binding var text: String
    var keyboardType: UIKeyboardType = .default
    var characterLimit: Int? = nil
    var isMultiline: Bool = false
    var isSecure: Bool = false

    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            ZStack(alignment: .topLeading) {
                if isMultiline {
                    if text.isEmpty {
                        Text(placeholder)
                            .foregroundColor(.black.opacity(0.5))
                            .padding(15)
                    }

                    TextEditor(text: $text)
                        .frame(minHeight: 100, maxHeight: 200)
                        .padding(10)
                        .background(Color("Primary_Neutral").opacity(0.06))
                        .cornerRadius(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color("Primary_Neutral").opacity(0.06), lineWidth: 1)
                        )
                        .foregroundColor(.primary)
                        .scrollContentBackground(.hidden)
                        .onChange(of: text) { _, newValue in
                            if let limit = characterLimit, newValue.count > limit {
                                text = String(newValue.prefix(limit))
                            }
                        }
                } else {
                    if isSecure {
                        SecureField(placeholder, text: $text)
                            .padding(10)
                            .background(Color("Primary_Neutral").opacity(0.06))
                            .cornerRadius(10)
                            .autocapitalization(.none)
                            .onChange(of: text) { _, newValue in
                                if let limit = characterLimit, newValue.count > limit {
                                    text = String(newValue.prefix(limit))
                                }
                            }
                    } else {
                        TextField(placeholder, text: $text, prompt: Text(placeholder)
                            .fontWeight(.medium)
                            .foregroundColor(.black.opacity(0.5)))
                            .keyboardType(keyboardType)
                            .autocapitalization(.none)
                            .padding(10)
                            .background(Color("Primary_Neutral").opacity(0.06))
                            .cornerRadius(10)
                            .onChange(of: text) { _, newValue in
                                if let limit = characterLimit, newValue.count > limit {
                                    text = String(newValue.prefix(limit))
                                }
                            }
                    }
                }
            }
        }
        .padding(.bottom, 20)
    }
}




