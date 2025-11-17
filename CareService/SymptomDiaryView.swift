//
//  SymptomDiaryView.swift
//  CareSupport
//
//  Created by Kaukab Farrukh on 2025-11-17.
//

import SwiftUI

struct SymptomDiaryView: View {
    struct Entry: Identifiable {
        let id = UUID()
        let date: Date
        let text: String
    }

    @State private var entries: [Entry] = []
    @State private var newText: String = ""

    // This is your "List of symptoms" carried forward
    private let commonSymptoms = [
        "Pain",
        "Tiredness",
        "Dizziness",
        "Shortness of breath",
        "Nausea",
        "Swelling",
        "Headache",
        "Fever",
        "Loss of appetite"
    ]

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

            VStack(spacing: 16) {
                Text("Use this diary to note how you feel. You can tap on a symptom below to add it quickly or write your own text.")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.leading)
                    .padding(.horizontal)

                // List of symptoms as chips
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 8) {
                        ForEach(commonSymptoms, id: \.self) { symptom in
                            Button {
                                addSymptom(symptom)
                            } label: {
                                Text(symptom)
                                    .font(.caption)
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 6)
                                    .background(Color.white)
                                    .foregroundColor(Color(red: 0.10, green: 0.60, blue: 0.55))
                                    .clipShape(Capsule())
                                    .overlay(
                                        Capsule()
                                            .stroke(Color(red: 0.10, green: 0.60, blue: 0.55).opacity(0.2),
                                                    lineWidth: 1)
                                    )
                            }
                        }
                    }
                    .padding(.horizontal)
                }

                // Input area
                VStack(alignment: .leading, spacing: 8) {
                    Text("New diary entry")
                        .font(.headline)

                    TextEditor(text: $newText)
                        .frame(minHeight: 80)
                        .padding(8)
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.black.opacity(0.05), lineWidth: 1)
                        )

                    HStack {
                        Spacer()
                        Button("Save entry") {
                            addEntry()
                        }
                        .disabled(newText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(
                            newText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
                            ? Color.gray.opacity(0.3)
                            : Color(red: 0.10, green: 0.60, blue: 0.55)
                        )
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                    }
                }
                .padding(.horizontal)

                // Saved entries
                if entries.isEmpty {
                    Spacer()
                    Text("No diary entries yet. Start by writing a short note above.")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    Spacer()
                } else {
                    List {
                        ForEach(entries.reversed()) { entry in
                            VStack(alignment: .leading, spacing: 4) {
                                Text(entry.date, style: .date)
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                                Text(entry.text)
                                    .font(.body)
                            }
                            .padding(.vertical, 4)
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .padding(.top)
        }
        .navigationTitle("Symptom diary")
        .navigationBarTitleDisplayMode(.inline)
    }

    private func addSymptom(_ symptom: String) {
        if newText.isEmpty {
            newText = symptom
        } else {
            newText += newText.hasSuffix(" ") ? symptom : " \(symptom)"
        }
    }

    private func addEntry() {
        let trimmed = newText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }

        let entry = Entry(date: Date(), text: trimmed)
        entries.append(entry)
        newText = ""
    }
}

#Preview {
    NavigationStack { SymptomDiaryView() }
}
