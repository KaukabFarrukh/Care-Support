//
//  CareHomeView.swift
//  CareSupport
//
//  Created by Kaukab Farrukh on 2025-11-17.
//

import SwiftUI
import FirebaseAuth

struct CareHomeView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var showDeleteAlert = false
    @State private var errorMessage: String?

    var body: some View {
        ZStack {
            // Background
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

            ScrollView {
                VStack(alignment: .leading, spacing: 24) {

                    // MARK: - Greeting
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Hello!")
                            .font(.title.bold())
                            .foregroundColor(Color(red: 0.10, green: 0.60, blue: 0.55))
                        Text("Here is your Care Support home. Choose what you want to do today.")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 24)

                    // MARK: - Main cards
                    VStack(spacing: 16) {
                        // 1. My care plan & survey
                        NavigationLink(destination: RecommendationsView1()) {
                            HomeCard(
                                title: "My care plan & survey",
                                subtitle: "Fill in the survey and see recommendations.",
                                systemImage: "list.bullet.clipboard",
                                tint: Color(red: 0.36, green: 0.54, blue: 0.96)
                            )
                        }

                        // 2. Symptom diary
                        NavigationLink(destination: Fillinginformation1()) {
                            HomeCard(
                                title: "Symptom diary",
                                subtitle: "Record symptoms using the list of measurements.",
                                systemImage: "heart.text.square",
                                tint: Color(red: 0.10, green: 0.60, blue: 0.55)
                            )
                        }

                        // 3. Care information
                        NavigationLink(destination: GeneralinformationIView2()) {
                            HomeCard(
                                title: "Care information",
                                subtitle: "Read about how the app and care support work.",
                                systemImage: "book.closed",
                                tint: Color(red: 0.91, green: 0.59, blue: 0.29)
                            )
                        }

                        // 4. Daily check-in
                        NavigationLink(destination: DailyCheckInView()) {
                            HomeCard(
                                title: "Daily check-in",
                                subtitle: "Record mood and energy for today.",
                                systemImage: "calendar.badge.checkmark",
                                tint: Color(red: 0.55, green: 0.41, blue: 0.88)
                            )
                        }

                        // 5. Care checklist
                        NavigationLink(destination: CareTasksChecklistView()) {
                            HomeCard(
                                title: "Care checklist",
                                subtitle: "Tick off simple tasks during the day.",
                                systemImage: "checklist",
                                tint: Color(red: 0.25, green: 0.60, blue: 0.40)
                            )
                        }
                    }
                    .padding(.horizontal, 24)

                    // Small spacer so account section isn’t glued to the cards
                    Spacer(minLength: 16)

                    // MARK: - Account section
                    VStack(alignment: .leading, spacing: 12) {
                        Divider()
                            .padding(.vertical, 8)

                        Text("Account")
                            .font(.headline)

                        HStack(spacing: 16) {
                            Button(action: handleLogout) {
                                Text("Log out")
                                    .font(.subheadline.weight(.semibold))
                                    .padding(.vertical, 10)
                                    .padding(.horizontal, 20)
                                    .background(Color(red: 0.90, green: 1.0, blue: 0.92))
                                    .foregroundColor(Color(red: 0.16, green: 0.60, blue: 0.34))
                                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                            }

                            Button(action: {
                                showDeleteAlert = true
                            }) {
                                Text("Delete account")
                                    .font(.subheadline.weight(.semibold))
                                    .padding(.vertical, 10)
                                    .padding(.horizontal, 20)
                                    .background(Color(red: 1.0, green: 0.75, blue: 0.75))
                                    .foregroundColor(.white)
                                    .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                            }
                        }
                    }
                    .padding(.horizontal, 24)
                    .padding(.bottom, 32)   // lifts the buttons up from very bottom
                }
            }
        }
        .navigationTitle("Care Support")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Delete account?", isPresented: $showDeleteAlert) {
            Button("Cancel", role: .cancel) {}
            Button("Delete", role: .destructive) {
                handleDeleteAccount()
            }
        } message: {
            Text("Your account and data will be removed. This cannot be undone.")
        }
        .alert("Error", isPresented: .constant(errorMessage != nil)) {
            Button("OK", role: .cancel) {
                errorMessage = nil
            }
        } message: {
            Text(errorMessage ?? "")
        }
    }

    // MARK: - Actions

    private func handleLogout() {
        do {
            try Auth.auth().signOut()
            dismiss()   // back to previous screen (Welcome / Start)
        } catch {
            errorMessage = "Could not log out. Please try again."
        }
    }

    private func handleDeleteAccount() {
        guard let user = Auth.auth().currentUser else {
            errorMessage = "No logged-in user."
            return
        }

        user.delete { error in
            if let error = error {
                errorMessage = "Could not delete account: \(error.localizedDescription)"
            } else {
                dismiss()
            }
        }
    }
}

// MARK: - Reusable card

struct HomeCard: View {
    let title: String
    let subtitle: String
    let systemImage: String
    let tint: Color

    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            Image(systemName: systemImage)
                .font(.title2)
                .padding(10)
                .background(tint.opacity(0.15))
                .foregroundColor(tint)
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.primary)
                Text(subtitle)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .fixedSize(horizontal: false, vertical: true)
            }

            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white.opacity(0.95))
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: .black.opacity(0.06), radius: 8, x: 0, y: 4)
    }
}

#Preview {
    NavigationStack { CareHomeView() }
}
