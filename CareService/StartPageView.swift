//
//  StartPageView.swift
//  CareService
//
//  Created by Kaukab Farrukh on 2025-05-22.
//

import SwiftUI
import AVFoundation
import Lottie

struct StartPageView: View {
    @State private var showAlert = false
    @State private var showHelpSheet = false
    private let speechSynthesizer = AVSpeechSynthesizer()

    var body: some View {
        NavigationStack {
            ZStack {
                // Background Gradient
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(red: 0.83, green: 0.93, blue: 1.0),  // Light cyan
                        Color(red: 0.73, green: 0.85, blue: 1.0),  // Soft lavender-blue
                        Color.white
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()

                VStack(spacing: 30) {
                    Spacer()

                    // Lottie Animation
                    LottieView(animationName: "care_animation", loopMode: .loop)
                        .frame(width: 150, height: 150)
                        .accessibilityLabel("Animated Care Logo")

                    Text("Care Support")
                        .font(.system(size: 40, weight: .bold, design: .rounded))
                        .foregroundColor(.blue)
                        .shadow(radius: 5)
                        .accessibilityLabel("App name: Care Support")

                    Text("Elderly Care Service")
                        .font(.headline)
                        .foregroundColor(.black.opacity(0.9))
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(Color.blue.opacity(0.7))
                        .cornerRadius(20)
                        .accessibilityLabel("Service: Elderly Care")

                    // General Info Button
                    Button("General Information") {
                        showAlert = true
                    }
                    .font(.subheadline)
                    .padding()
                    .frame(maxWidth: 250)
                    .background(Color.white.opacity(0.85))
                    .foregroundColor(.black)
                    .cornerRadius(15)
                    .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.white.opacity(0.3), lineWidth: 1))
                    .accessibilityLabel("General information about the app")
                    .alert(isPresented: $showAlert) {
                        Alert(
                            title: Text("General Information"),
                            message: Text("This app helps care for elderly or sick persons. After registration, you'll complete a short survey to build a care plan. Includes a symptom diary and expert-written articles."),
                            dismissButton: .default(Text("OK"))
                        )
                    }

                    // Start Button with Haptic Feedback
                    NavigationLink(destination: WelcomePage()) {
                        Text("Start")
                            .font(.headline)
                            .foregroundColor(.black)
                            .frame(width: 140, height: 50)
                            .background(Color.white)
                            .cornerRadius(25)
                            .shadow(color: .blue.opacity(0.3), radius: 10, x: 0, y: 5)
                    }
                    .simultaneousGesture(TapGesture().onEnded {
                        let generator = UIImpactFeedbackGenerator(style: .medium)
                        generator.impactOccurred()
                    })
                    .accessibilityLabel("Start using the app")

                    // Emergency SOS Button
                    Button(action: {
                        let generator = UIImpactFeedbackGenerator(style: .rigid)
                        generator.impactOccurred()

                        if let url = URL(string: "tel://1177") {
                            UIApplication.shared.open(url)
                        }
                    }) {
                        Label("Call Emergency", systemImage: "phone.fill")
                            .padding()
                            .frame(width: 200)
                            .foregroundColor(.white)
                            .background(Color.red)
                            .cornerRadius(25)
                            .shadow(radius: 5)
                    }
                    .accessibilityLabel("Call emergency caregiver")

                    Spacer()
                }
                .padding()

                // Floating Help Icon (bottom-right)
                VStack {
                    Spacer()
                    HStack {
                        Spacer()

                        Button(action: {
                            speak(text: "This screen helps you start your care plan, call 1177 for medical help, or get more information.")
                            showHelpSheet = true
                        }) {
                            Image(systemName: "questionmark.circle.fill")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .foregroundColor(.blue)
                                .padding()
                        }
                        .accessibilityLabel("Help information")
                    }
                }
            }
            .onAppear {
                speakWelcomeMessage()
            }
            .sheet(isPresented: $showHelpSheet) {
                VStack(alignment: .leading, spacing: 20) {
                    Text("🆘 Help & Info")
                        .font(.title)
                        .fontWeight(.bold)

                    Text("• Tap **Start** to begin your care plan.")
                    Text("• Tap **General Information** to learn how the app works.")
                    Text("• Tap **Call Emergency** to reach 1177 for medical advice.")
                    Text("• Tap the mic (coming soon) to record symptoms.")

                    Spacer()

                    Button("Close") {
                        showHelpSheet = false
                    }
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                }
                .padding()
            }
        }
    }

    // MARK: - Speech Functions

    private func speakWelcomeMessage() {
        let message = "Welcome to Care Support. Your assistant for elderly and health care. Tap start to begin."
        let utterance = AVSpeechUtterance(string: message)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        speechSynthesizer.speak(utterance)
    }

    private func speak(text: String) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        utterance.rate = 0.5
        speechSynthesizer.speak(utterance)
    }
}

#Preview {
    StartPageView()
}
