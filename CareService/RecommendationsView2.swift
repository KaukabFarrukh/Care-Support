//
//  RecommendationsView2.swift
//  CareService
//
//  Created by Kaukab Farrukh on 2025-05-22.
//

import SwiftUI

struct RecommendationsView2: View {
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
                VStack(alignment: .leading, spacing: 24) {

                    // Header
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Mobility & walking support")
                            .font(.title3.weight(.semibold))

                        Text("These tips can help a person move more safely at home. Always follow your doctor’s advice first.")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 24)

                    // Section 1: Before you move
                    SectionHeader(title: "Before you move")

                    RecommendationCard(
                        icon: "lightbulb",
                        title: "Plan the route",
                        text: "Decide where you are going and remove objects on the floor (cables, toys, rugs that slip)."
                    )

                    RecommendationCard(
                        icon: "figure.stand",
                        title: "Check your support",
                        text: "Make sure the cane, walker or furniture you use for support is stable and within reach."
                    )

                    RecommendationCard(
                        icon: "shoeprints.fill",
                        title: "Shoes & clothes",
                        text: "Wear closed shoes with a non-slip sole. Avoid very loose clothes that can catch on furniture."
                    )

                    // Section 2: While walking
                    SectionHeader(title: "While walking")

                    RecommendationCard(
                        icon: "figure.walk.motion",
                        title: "Small, slow steps",
                        text: "Encourage calm, short steps instead of rushing. Stop and rest if the person feels tired or dizzy."
                    )

                    RecommendationCard(
                        icon: "arrow.up.and.down",
                        title: "Use both hands when needed",
                        text: "When standing up or sitting down, use both hands to push from the chair or bed if possible."
                    )

                    RecommendationCard(
                        icon: "exclamationmark.triangle",
                        title: "Avoid multitasking",
                        text: "Do not talk on the phone, carry heavy objects or turn quickly while walking."
                    )

                    // Section 3: Home adjustments
                    SectionHeader(title: "Home adjustments")

                    RecommendationCard(
                        icon: "bed.double",
                        title: "Safe bedroom",
                        text: "Keep a lamp close to the bed, and make sure the path to the toilet at night is free of objects."
                    )

                    RecommendationCard(
                        icon: "bathtub",
                        title: "Bathroom safety",
                        text: "Use non-slip mats, grab bars if needed, and a stable chair for showering for people with low balance."
                    )

                    RecommendationCard(
                        icon: "house",
                        title: "Ask for help",
                        text: "If you notice repeated near-falls, pain or big changes in balance, contact a nurse or doctor."
                    )

                    Spacer(minLength: 24)
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 24)
            }
        }
        .navigationTitle("Mobility support")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Small helpers

private struct SectionHeader: View {
    let title: String

    var body: some View {
        Text(title)
            .font(.headline)
            .padding(.top, 8)
    }
}

private struct RecommendationCard: View {
    let icon: String
    let title: String
    let text: String

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: icon)
                .font(.title3)
                .padding(8)
                .background(Color.white)
                .foregroundColor(Color.blue)
                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.subheadline.weight(.semibold))
                Text(text)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            Spacer()
        }
        .padding(12)
        .background(Color.white.opacity(0.95))
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 3)
    }
}

#Preview {
    NavigationStack { RecommendationsView2() }
}
