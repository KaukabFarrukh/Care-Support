//
//  WelcomePage.swift
//  CareService
//
//  Created by Kaukab Farrukh on 2025-05-22.
//



import SwiftUI
import Lottie

struct WelcomePage: View {
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                ZStack {
                    Color("background")
                        .ignoresSafeArea()

                    VStack(spacing: 20) {
                        // Animated Lottie Icon (replacing static image)
                        ZStack {
                            Circle()
                                .fill(Color.white.opacity(0.2))
                                .frame(width: geometry.size.width * 0.3)
                                .shadow(color: .blue.opacity(0.5), radius: 20)

                            // Add your Lottie animation here
                            LottieView(animationName: "care_animation", loopMode: .loop)
                                .frame(width: geometry.size.width * 0.2, height: geometry.size.width * 0.2)
                                .accessibilityLabel("Animated Care Icon")
                        }

                        Text("This App helps you")
                            .font(.title)
                            .italic()
                            .foregroundColor(.blue)
                            .padding(.bottom, 10)

                        VStack(alignment: .leading, spacing: 10) {
                            Label("To create a care plan", systemImage: "checkmark.circle.fill")
                                .foregroundColor(.white)
                            Label("To keep notes in a diary", systemImage: "checkmark.circle.fill")
                                .foregroundColor(.white)
                            Label("To use the library", systemImage: "checkmark.circle.fill")
                                .foregroundColor(.white)
                        }
                        .padding()

                        NavigationLink("Log in", destination: LoginView())
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(width: geometry.size.width * 0.5, height: 50)
                            .background(
                                LinearGradient(gradient: Gradient(colors: [.blue, .purple]),
                                               startPoint: .leading,
                                               endPoint: .trailing)
                            )
                            .cornerRadius(25)
                            .shadow(radius: 10)

                        NavigationLink("Registration", destination: RegistrationView())
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(width: geometry.size.width * 0.5, height: 50)
                            .background(
                                LinearGradient(gradient: Gradient(colors: [.green, .mint]),
                                               startPoint: .leading,
                                               endPoint: .trailing)
                            )
                            .cornerRadius(25)
                            .shadow(radius: 10)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding()
                }
            }
        }
    }
}

#Preview {
    WelcomePage()
}
