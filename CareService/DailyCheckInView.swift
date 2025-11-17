//
//  DailyCheckInView.swift
//  CareService
//
//  Created by Kaukab Farrukh on 2025-11-17.
//

import SwiftUI

struct DailyCheckInView: View {
    struct CheckIn: Identifiable {
        let id = UUID()
        let date: Date
        let mood: Mood
        let energy: Double
        let note: String
    }

    enum Mood: String, CaseIterable, Identifiable {
        case happy = "Happy"
        case ok = "OK"
        case tired = "Tired"
        case sad = "Sad"

        var id: String { rawValue }

        var symbol: String {
            switch self {
            case .happy: return "face.smiling"
            case .ok:    return "face.neutral"
            case .tired: return "face.dashed"
            case .sad:   return "face.frown"
            }
        }
    }

    @State private var selectedMood: Mood = .ok
    @State private var energy: Double = 3
    @State private var note: String = ""
    @State private var savedCheckIns: [CheckIn] = []
    @State private var showSavedAlert = false

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

            VStack(spacing: 20) {
                Text("Daily check-in")
                    .font(.title2.weight(.bold))
                    .padding(.top, 16)

                Text("Once a day, quickly record how you feel. This can help you and your caregiver see changes over time.")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)

                // Mood selection
                VStack(alignment: .leading, spacing: 8) {
                    Text("Mood")
                        .font(.headline)

                    HStack(spacing: 12) {
                        ForEach(Mood.allCases) { mood in
                            Button {
                                selectedMood = mood
                            } label: {
                                VStack(spacing: 4) {
                                    Image(systemName: mood.symbol)
                                        .font(.title2)
                                    Text(mood.rawValue)
                                        .font(.caption)
                                }
                                .padding(8)
                                .frame(maxWidth: .infinity)
                                .background(
                                    selectedMood == mood
                                    ? Color(red: 0.10, green: 0.60, blue: 0.55).opacity(0.15)
                                    : Color.white
                                )
                                .foregroundColor(
                                    selectedMood == mood
                                    ? Color(red: 0.10, green: 0.60, blue: 0.55)
                                    : .primary
                                )
                                .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(
                                            selectedMood == mood
                                            ? Color(red: 0.10, green: 0.60, blue: 0.55)
                                            : Color.black.opacity(0.05),
                                            lineWidth: 1
                                        )
                                )
                            }
                        }
                    }
                }
                .padding(.horizontal)

                // Energy slider
                VStack(alignment: .leading, spacing: 8) {
                    Text("Energy level")
                        .font(.headline)

                    HStack {
                        Text("Low")
                            .font(.caption)
                        Slider(value: $energy, in: 1...5, step: 1)
                        Text("High")
                            .font(.caption)
                    }

                    Text("Current energy: \(Int(energy))/5")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                .padding(.horizontal)

                // Note
                VStack(alignment: .leading, spacing: 8) {
                    Text("Short note")
                        .font(.headline)

                    TextEditor(text: $note)
                        .frame(minHeight: 80)
                        .padding(8)
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.black.opacity(0.05), lineWidth: 1)
                        )
                }
                .padding(.horizontal)

                // Save button
                Button {
                    saveCheckIn()
                } label: {
                    Text("Save today’s check-in")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .frame(height: 48)
                        .background(Color(red: 0.10, green: 0.60, blue: 0.55))
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                }
                .padding(.horizontal, 40)
                .padding(.top, 4)

                // Simple history (in this session)
                if !savedCheckIns.isEmpty {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Recent check-ins")
                            .font(.headline)

                        ForEach(savedCheckIns.suffix(5).reversed()) { check in
                            HStack {
                                Text(check.date, style: .date)
                                    .font(.caption)
                                Text(check.mood.rawValue)
                                    .font(.caption.weight(.semibold))
                                Text("Energy \(Int(check.energy))/5")
                                    .font(.caption)
                                Spacer()
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 8)
                }

                Spacer()
            }
        }
        .navigationTitle("Daily check-in")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Saved", isPresented: $showSavedAlert) {
            Button("OK", role: .cancel) {}
        } message: {
            Text("Your check-in for today has been saved.")
        }
    }

    private func saveCheckIn() {
        let entry = CheckIn(
            date: Date(),
            mood: selectedMood,
            energy: energy,
            note: note.trimmingCharacters(in: .whitespacesAndNewlines)
        )
        savedCheckIns.append(entry)
        note = ""
        showSavedAlert = true
    }
}

#Preview {
    NavigationStack { DailyCheckInView() }
}
