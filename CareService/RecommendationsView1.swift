//
//  RecommendationsView1.swift
//  CareSupport
//
//  Created by Kaukab Farrukh on 2025-05-22.
//

import SwiftUI

struct RecommendationsView1: View {
    @Environment(\.dismiss) private var dismiss   // 👈 to go back to CareHomeView

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [
                    Color("background"),
                    Color.white
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            ScrollView {
                VStack(spacing: 24) {

                    // Intro
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Your care recommendations")
                            .font(.headline)

                        Text("These suggestions support everyday care for a person who needs extra help at home. You can use them together with a caregiver or on your own.")
                            .font(.subheadline)
                            .foregroundColor(.secondary)

                        Text("Note: The survey is reserved for registered users.")
                            .font(.footnote.weight(.semibold))
                            .foregroundColor(.red)
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 24)

                    // Survey button
                    NavigationLink(destination: Survey12()) {
                        Text("Do a survey")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .frame(height: 52)
                            .background(
                                LinearGradient(
                                    gradient: Gradient(colors: [
                                        Color.blue, Color.purple
                                    ]),
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .foregroundColor(.white)
                            .cornerRadius(24)
                            .shadow(color: Color.blue.opacity(0.4), radius: 10, x: 0, y: 4)
                    }
                    .padding(.horizontal, 40)

                    // After survey section (Mobility & Daily care routine)
                    VStack(alignment: .leading, spacing: 12) {
                        Text("After your survey")
                            .font(.headline)
                            .padding(.bottom, 4)

                        Text("Once you have filled in the survey, you can read more focused advice.")
                            .font(.subheadline)
                            .foregroundColor(.secondary)

                        NavigationLink(destination: RecommendationsView2()) {
                            RecommendationMiniCard(
                                title: "Mobility & walking support",
                                subtitle: "Practical tips for safe movement at home.",
                                systemImage: "figure.walk"
                            )
                        }

                        NavigationLink(destination: RecommendationsView3()) {
                            RecommendationMiniCard(
                                title: "Daily care routine",
                                subtitle: "Example of a simple day structure.",
                                systemImage: "sun.max"
                            )
                        }
                    }
                    .padding(.horizontal, 24)

                    // Back to home button
                    Divider()
                        .padding(.horizontal, 24)
                        .padding(.top, 8)

                    Button(action: {
                        dismiss()          // 👈 returns to CareHomeView
                    }) {
                        Text("Back to home")
                            .font(.subheadline.weight(.semibold))
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.white)
                            .foregroundColor(.blue)
                            .cornerRadius(12)
                            .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                    }
                    .padding(.horizontal, 24)
                    .padding(.bottom, 24)
                }
            }
        }
        .navigationTitle("Care recommendations")
        .navigationBarTitleDisplayMode(.inline)
    }
}

private struct RecommendationMiniCard: View {
    let title: String
    let subtitle: String
    let systemImage: String

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: systemImage)
                .font(.title3)
                .padding(8)
                .background(Color.white)
                .foregroundColor(Color.blue)
                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.subheadline.weight(.semibold))
                Text(subtitle)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }

            Spacer()
        }
        .padding(12)
        .background(Color.white.opacity(0.9))
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
    }
}

#Preview {
    NavigationStack { RecommendationsView1() }
}
