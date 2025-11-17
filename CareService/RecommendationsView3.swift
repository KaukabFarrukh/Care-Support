//
//  RecommendationsView3.swift
//  CareService
//
//  Created by Kaukab Farrukh on 2025-05-22.
//

import SwiftUI

struct RecommendationsView3: View {
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
                        Text("Daily care routine")
                            .font(.title3.weight(.semibold))

                        Text("This is an example day that can be adapted together with a caregiver. Always follow medical advice first.")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 24)

                    // Morning
                    RoutineSection(
                        title: "Morning",
                        icon: "sunrise.fill",
                        items: [
                            "Check how the person feels: pain, dizziness, mood.",
                            "Offer water and morning medication, if prescribed.",
                            "Support washing, brushing teeth and getting dressed.",
                            "If possible, do a short movement exercise (for example standing up and sitting down a few times)."
                        ]
                    )

                    // Daytime
                    RoutineSection(
                        title: "During the day",
                        icon: "clock",
                        items: [
                            "Plan regular small meals or snacks instead of one big meal.",
                            "Encourage drinking water or other recommended drinks every 1–2 hours.",
                            "Support safe movement inside the home or a short walk outside if safe.",
                            "Use the symptom diary to record important changes (pain, temperature, breathing)."
                        ]
                    )

                    // Evening
                    RoutineSection(
                        title: "Evening",
                        icon: "moon.stars.fill",
                        items: [
                            "Prepare the bedroom: good light to the toilet, clear the floor of objects.",
                            "Give evening medication and a light snack if recommended.",
                            "Talk shortly about the day: what went well, what was difficult.",
                            "Write one or two sentences in the diary for the caregiver or nurse."
                        ]
                    )

                    // Extra note card
                    InfoCard(
                        title: "When to contact healthcare",
                        text: "Call your healthcare provider or emergency number if you notice sudden strong pain, difficulty breathing, high fever, repeated falls, or if the person is unusually confused or sleepy."
                    )

                    Spacer(minLength: 24)
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 24)
            }
        }
        .navigationTitle("Daily routine")
        .navigationBarTitleDisplayMode(.inline)
    }
}

// MARK: - Helpers

private struct RoutineSection: View {
    let title: String
    let icon: String
    let items: [String]

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 8) {
                Image(systemName: icon)
                    .foregroundColor(Color(red: 0.10, green: 0.60, blue: 0.55))
                Text(title)
                    .font(.headline)
            }

            VStack(alignment: .leading, spacing: 6) {
                ForEach(items, id: \.self) { item in
                    HStack(alignment: .top, spacing: 6) {
                        Text("•")
                        Text(item)
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
            }
            .padding(12)
            .background(Color.white.opacity(0.95))
            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
            .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 3)
        }
    }
}

private struct InfoCard: View {
    let title: String
    let text: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline)
            Text(text)
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding(12)
        .background(Color.white.opacity(0.95))
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 3)
        .padding(.top, 4)
    }
}

#Preview {
    NavigationStack { RecommendationsView3() }
}
