//
//  WelcomePage.swift
//  CareSupport
//
//  Created by Kaukab Farrukh on 2025-05-22.
//

import SwiftUI
import Lottie

struct WelcomePage: View {
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Background – same mint feel as StartPageView
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color("background"),
                        Color(red: 0.90, green: 1.0, blue: 0.97),
                        Color.white
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()

                VStack(spacing: 28) {
                    Spacer(minLength: 40)

                    // MARK: - Top card with animation
                    VStack(spacing: 20) {
                        ZStack {
                            Circle()
                                .fill(Color.white.opacity(0.25))
                                .frame(width: geometry.size.width * 0.35)
                                .shadow(color: Color.black.opacity(0.08),
                                        radius: 18, x: 0, y: 10)

                            LottieView(animationName: "care_animation", loopMode: .loop)
                                .frame(width: geometry.size.width * 0.22,
                                       height: geometry.size.width * 0.22)
                                .accessibilityLabel("Animated care icon")
                        }

                        VStack(spacing: 6) {
                            Text("Welcome to Care Support")
                                .font(.title2.weight(.semibold))
                                .foregroundColor(Color(red: 0.10, green: 0.60, blue: 0.55))
                                .multilineTextAlignment(.center)

                            Text("This app helps you and your caregiver stay organized, informed and connected.")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 16)
                        }

                        // Short feature list
                        VStack(alignment: .leading, spacing: 8) {
                            FeatureRow(text: "Create a simple care plan")
                            FeatureRow(text: "Keep notes in a daily diary")
                            FeatureRow(text: "Read trusted care information")
                        }
                        .padding(16)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color.white.opacity(0.75))
                        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                    }
                    .padding(.horizontal, 24)

                    Spacer()

                    // MARK: - Actions
                    VStack(spacing: 12) {
                        // Primary: Log in
                        NavigationLink(destination: LoginView()) {
                            Text("Log in")
                                .font(.headline)
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                                .background(Color(red: 0.10, green: 0.60, blue: 0.55))
                                .foregroundColor(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
                                .shadow(color: Color(red: 0.10, green: 0.60, blue: 0.55).opacity(0.3),
                                        radius: 10, x: 0, y: 5)
                        }

                        // Secondary: Registration
                        NavigationLink(destination: RegistrationView()) {
                            Text("Create new account")
                                .font(.headline)
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                                .background(Color.white.opacity(0.9))
                                .foregroundColor(Color(red: 0.10, green: 0.60, blue: 0.55))
                                .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 18)
                                        .stroke(Color(red: 0.10, green: 0.60, blue: 0.55).opacity(0.25),
                                                lineWidth: 1)
                                )
                        }

                        // NEW: Explore without account (functional difference)
                        NavigationLink(destination: GeneralinformationIView2()) {
                            Text("Explore without an account")
                                .font(.subheadline)
                                .underline()
                                .foregroundColor(.secondary)
                        }
                        .padding(.top, 4)
                    }
                    .padding(.horizontal, 40)
                    .padding(.bottom, 32)
                }
            }
        }
    }
}

// Small reusable row for the feature list
private struct FeatureRow: View {
    let text: String

    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: "checkmark.circle.fill")
                .foregroundColor(Color(red: 0.10, green: 0.60, blue: 0.55))
            Text(text)
                .font(.subheadline)
                .foregroundColor(.primary)
            Spacer()
        }
    }
}

#Preview {
    WelcomePage()
}

