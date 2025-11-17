//
//  StartPageView.swift
//  CareSupport
//
//  Created by Kaukab Farrukh on 2025-05-22.
//

import SwiftUI
import AVFoundation
import Lottie

struct StartPageView: View {
    @State private var showInfoAlert = false
    @State private var showHelpSheet = false
    @State private var showCallAlert = false

    private let speechSynthesizer = AVSpeechSynthesizer()

    // Your emergency caregiver / support number
    private let emergencyNumber = "+46704149663"

    var body: some View {
        NavigationStack {
            ZStack {
                // MARK: - Background
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color("background"),                               // mint from Assets
                        Color(red: 0.88, green: 1.0, blue: 0.95),          // softer mint
                        Color.white
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .ignoresSafeArea()

                VStack(spacing: 24) {
                    Spacer(minLength: 40)

                    // MARK: - App Card
                    VStack(spacing: 20) {
                        // Logo / Animation
                        LottieView(animationName: "care_animation", loopMode: .loop)
                            .frame(width: 120, height: 120)
                            .accessibilityLabel("Animated care logo")

                        VStack(spacing: 6) {
                            Text("Care Support")
                                .font(.system(size: 32, weight: .bold, design: .rounded))
                                .foregroundColor(Color(red: 0.10, green: 0.60, blue: 0.55))
                                .accessibilityLabel("App name Care Support")

                            Text("Your daily care companion")
                                .font(.subheadline)
                                .foregroundColor(.secondary)
                                .multilineTextAlignment(.center)
                        }

                        // Tag / pill
                        Text("Elderly & home care service")
                            .font(.caption)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 6)
                            .background(
                                Color(red: 0.10, green: 0.60, blue: 0.55)
                                    .opacity(0.15)
                            )
                            .foregroundColor(Color(red: 0.10, green: 0.60, blue: 0.55))
                            .clipShape(Capsule())
                            .accessibilityLabel("Service: elderly and home care")

                        Divider()
                            .padding(.top, 4)

                        // MARK: - Buttons inside card
                        VStack(spacing: 12) {
                            // General Info (secondary)
                            Button(action: {
                                showInfoAlert = true
                            }) {
                                HStack {
                                    Image(systemName: "info.circle")
                                    Text("General Information")
                                }
                                .font(.subheadline)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.white.opacity(0.8))
                                .foregroundColor(.primary)
                                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 16)
                                        .stroke(Color.black.opacity(0.05), lineWidth: 1)
                                )
                            }
                            .alert("General Information", isPresented: $showInfoAlert) {
                                Button("OK", role: .cancel) {}
                            } message: {
                                Text("This app helps care for elderly or sick persons. After registration, you'll complete a short survey to build a care plan. It includes a symptom diary and expert-written articles.")
                            }
                            .accessibilityLabel("General information about the app")

                            // Start (primary)
                            NavigationLink(destination: WelcomePage()) {
                                Text("Start")
                                    .font(.headline)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 50)
                                    .background(Color(red: 0.10, green: 0.60, blue: 0.55))
                                    .foregroundColor(.white)
                                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                                    .shadow(color: Color(red: 0.10, green: 0.60, blue: 0.55).opacity(0.3),
                                            radius: 10, x: 0, y: 5)
                            }
                            .simultaneousGesture(TapGesture().onEnded {
                                let generator = UIImpactFeedbackGenerator(style: .medium)
                                generator.impactOccurred()
                            })
                            .accessibilityLabel("Start using the app")
                        }
                    }
                    .padding(24)
                    .frame(maxWidth: 340)
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 28, style: .continuous))
                    .shadow(color: .black.opacity(0.1), radius: 18, x: 0, y: 10)

                    Spacer()

                    // MARK: - Emergency Section + Help Button
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Need urgent support?")
                            .font(.footnote)
                            .foregroundColor(.secondary)

                        Button(action: {
                            let generator = UIImpactFeedbackGenerator(style: .rigid)
                            generator.impactOccurred()
                            callEmergencyContact()
                        }) {
                            HStack(spacing: 12) {
                                Image(systemName: "phone.fill")
                                    .font(.title3)
                                    .padding(10)
                                    .background(Color.white.opacity(0.2))
                                    .clipShape(Circle())

                                VStack(alignment: .leading, spacing: 2) {
                                    Text("Call emergency contact")
                                        .font(.subheadline.weight(.semibold))
                                    Text("Connect to your caregiver or family member")
                                        .font(.caption)
                                        .foregroundColor(.white.opacity(0.85))
                                }
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .font(.caption.weight(.semibold))
                                    .opacity(0.9)
                            }
                            .padding()
                            .background(Color(red: 1.00, green: 0.42, blue: 0.42))
                            .foregroundColor(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                            .shadow(color: Color(red: 1.00, green: 0.42, blue: 0.42).opacity(0.4),
                                    radius: 10, x: 0, y: 5)
                        }
                        .accessibilityLabel("Call your emergency caregiver")

                        // Help button aligned to the right, under the card
                        HStack {
                            Spacer()
                            Button(action: {
                                speak(text: "This screen helps you start your care plan, read general information, or call your emergency caregiver for help.")
                                showHelpSheet = true
                            }) {
                                Image(systemName: "questionmark.circle.fill")
                                    .resizable()
                                    .frame(width: 40, height: 40)
                                    .foregroundColor(Color(red: 0.10, green: 0.60, blue: 0.55))
                            }
                            .accessibilityLabel("Help information")
                        }
                    }
                    .padding(.horizontal, 24)
                    .padding(.bottom, 24)
                    .alert("Calling not supported", isPresented: $showCallAlert) {
                        Button("OK", role: .cancel) {}
                    } message: {
                        Text("This device cannot make phone calls.")
                    }
                } // end VStack(spacing: 24)
            } // end ZStack
            .onAppear {
                speakWelcomeMessage()
            }
            .sheet(isPresented: $showHelpSheet) {
                VStack(alignment: .leading, spacing: 20) {
                    Text("🆘 Help & Info")
                        .font(.title2.weight(.bold))

                    Text("• Tap **Start** to begin your care plan and answer a short survey.")
                    Text("• Tap **General Information** to learn how the app works.")
                    Text("• Tap **Call emergency contact** to reach your caregiver or family member.")
                    Text("• Voice features will help you if reading small text is difficult.")

                    Spacer()

                    Button("Close") {
                        showHelpSheet = false
                    }
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color(red: 0.10, green: 0.60, blue: 0.55))
                    .foregroundColor(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                }
                .padding()
            }
        } // end NavigationStack
    }

    // MARK: - Emergency Call Logic

    private func callEmergencyContact() {
        let cleaned = emergencyNumber.replacingOccurrences(of: " ", with: "")

        guard let url = URL(string: "tel://\(cleaned)") else {
            showCallAlert = true
            return
        }

        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            showCallAlert = true   // e.g. on iPad without calling ability
        }
    }

    // MARK: - Speech Functions

    private func speakWelcomeMessage() {
        let message = "Welcome to Care Support. Your assistant for elderly and home care. Tap start to begin."
        let utterance = AVSpeechUtterance(string: message)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        utterance.rate = 0.48
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

