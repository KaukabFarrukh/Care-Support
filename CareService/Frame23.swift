//
//  Frame23.swift
//  CareService
//
//  Created by Kamila Ponomarova on 2025-05-22.
//



import SwiftUI

struct Frame23View: View {
    @State private var currentTime: String = DateFormatter.localizedString(from: Date(), dateStyle: .none, timeStyle: .short)
    @State private var patient: String = UserDefaults.standard.string(forKey: "SavedName") ?? "Unknown"
    @State private var gender: String = UserDefaults.standard.string(forKey: "SavedGender") ?? "Unspecified"
    @State private var age: String = {
        let dob = UserDefaults.standard.object(forKey: "SavedDOB") as? Date ?? Date()
        let ageComponents = Calendar.current.dateComponents([.year], from: dob, to: Date())
        return "\(ageComponents.year ?? 0)"
    }()
    @State private var weight: Float = UserDefaults.standard.float(forKey: "savedWeight")
    @State private var pressure: String = UserDefaults.standard.string(forKey: "savedBloodPressure") ?? "0 / 0"
    @State private var oxygen: Int = UserDefaults.standard.integer(forKey: "savedOxygen")
    @State private var pulse: Int = UserDefaults.standard.integer(forKey: "savedPulse")
    @State private var temperature: Float = UserDefaults.standard.float(forKey: "savedBodyTemperature")
    @State private var sugarLevel: Float = UserDefaults.standard.float(forKey: "savedBloodSugarLevel")

    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack(spacing: 24) {
                    HStack {
                        Text(currentTime)
                            .font(.headline)
                            .padding()
                            .frame(width: 120, height: 44)
                            .background(Color.white)
                            .cornerRadius(12)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                            )

                        Spacer()

                        Button("TODAY") {
                            updateCurrentTime()
                        }
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: 120, height: 44)
                        .background(Color.blue)
                        .cornerRadius(12)
                    }
                    .padding(.horizontal)

                    VStack(spacing: 12) {
                        entryField(label: "Name", value: patient)
                        entryField(label: "Gender", value: gender)
                        entryField(label: "Age", value: age)
                        entryField(label: "Weight", value: "\(weight) kg")
                        entryField(label: "Pressure", value: "\(pressure) mmHg")
                        entryField(label: "Oxygen", value: "\(oxygen)%")
                        entryField(label: "Pulse", value: "\(pulse) bpm")
                        entryField(label: "Body Temperature", value: "\(temperature)°C")
                        entryField(label: "Sugar Level", value: "\(sugarLevel) mmol/L")
                    }
                    .padding()
                    .frame(maxWidth: 600)
                    .background(Color.white)
                    .cornerRadius(16)
                    .shadow(color: Color.black.opacity(0.05), radius: 10, x: 0, y: 4)

                    VStack(spacing: 16) {
                        NavigationLink(destination: Fillinginformation1()) {
                            Text("Back to List of Symptoms")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(width: min(geometry.size.width * 0.5, 280), height: 50)
                                .background(Color.green)
                                .cornerRadius(12)
                        }

                        NavigationLink(destination: RecommendationsView1()) {
                            Text("Back to Recommendations")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(width: min(geometry.size.width * 0.5, 280), height: 50)
                                .background(Color.green)
                                .cornerRadius(12)
                        }
                    }
                    .padding(.top, 20)
                    .padding(.bottom, 40)
                }
                .padding(.top, 40)
                .padding(.horizontal)
            }
            .background(Color("background"))
            .ignoresSafeArea()
        }
        .navigationTitle("Diary")
        .navigationBarTitleDisplayMode(.inline)
    }

    private func updateCurrentTime() {
        currentTime = DateFormatter.localizedString(from: Date(), dateStyle: .none, timeStyle: .short)
    }

    @ViewBuilder
    private func entryField(label: String, value: String) -> some View {
        HStack {
            Text("\(label):")
                .font(.headline)
            Spacer()
            Text(value)
                .font(.subheadline)
                .foregroundColor(.black)
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(12)
    }
}
