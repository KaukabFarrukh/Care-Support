//
//  Frame22.swift
//  CareService
//
//  Created by Kamila Ponomarova on 2025-05-22.
//



import SwiftUI

struct Frame22View: View {
    @Binding var bloodSugarLevel: String
    @State private var notice: String = ""
    @State private var showConfirmation = false
    @State private var currentTime: String = ""
    @State private var selectedMealTiming: String = "Before a meal"
    @State private var navigateToNext = false

    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                ZStack {
                    Color("background").ignoresSafeArea()

                    ScrollView {
                        VStack(spacing: 24) {
                            VStack(spacing: 4) {
                                Text("Your Blood Sugar level is")
                                    .font(.headline)
                                    .multilineTextAlignment(.center)

                                Text(bloodSugarLevel)
                                    .font(.system(size: 50, weight: .bold))
                                    .foregroundColor(.black)

                                Text("mmol/L")
                                    .font(.subheadline)
                            }

                            HStack(spacing: 16) {
                                Text(currentTime)
                                    .font(.headline)
                                    .foregroundColor(.black)
                                    .padding()
                                    .frame(width: geometry.size.width * 0.3, height: 44)
                                    .background(Color.white)
                                    .cornerRadius(12)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                                    )

                                Button("TODAY") {
                                    updateCurrentTime()
                                }
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(width: geometry.size.width * 0.3, height: 44)
                                .background(Color.blue)
                                .cornerRadius(12)
                            }

                            VStack(spacing: 8) {
                                Text("When was this sugar level measured?")
                                    .font(.headline)
                                    .multilineTextAlignment(.center)

                                mealTimingOptions()
                            }

                            TextField("Enter notice", text: $notice)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(12)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                                )
                                .padding(.horizontal)

                            Button("Save") {
                                saveInformation()
                                showConfirmation = true
                            }
                            .alert(isPresented: $showConfirmation) {
                                Alert(
                                    title: Text("Saved"),
                                    message: Text("Your information has been saved."),
                                    dismissButton: .default(Text("OK"))
                                )
                            }
                            .foregroundColor(.white)
                            .frame(width: 150, height: 44)
                            .background(Color.blue)
                            .cornerRadius(12)

                            NavigationLink(destination: Frame23View(), isActive: $navigateToNext) {
                                EmptyView()
                            }

                            Button("Next") {
                                saveInformation()
                                navigateToNext = true
                            }
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(width: 180, height: 50)
                            .background(Color.green)
                            .cornerRadius(12)
                            .padding(.top, 10)
                        }
                        .padding()
                        .frame(maxWidth: 600)
                        .frame(maxWidth: .infinity)
                        .padding(.bottom, 30)
                        .onAppear {
                            updateCurrentTime()
                        }
                    }
                }
            }
            .navigationTitle("Blood Sugar")
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    private func updateCurrentTime() {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        currentTime = formatter.string(from: Date())
    }

    private func saveInformation() {
        UserDefaults.standard.set(Float(bloodSugarLevel) ?? 0, forKey: "savedBloodSugarLevel")
        UserDefaults.standard.set(notice, forKey: "savedNotice")
    }

    private func mealTimingOptions() -> some View {
        VStack(alignment: .leading, spacing: 8) {
            ForEach(["Before a meal", "After a meal", "Fasting blood sugar", "Bedtime blood sugar"], id: \.self) { timing in
                Button(action: {
                    selectedMealTiming = timing
                }) {
                    HStack {
                        Image(systemName: selectedMealTiming == timing ? "checkmark.circle.fill" : "circle")
                            .foregroundColor(selectedMealTiming == timing ? .blue : .gray)
                        Text(timing)
                            .fontWeight(.medium)
                            .foregroundColor(.black)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.white)
                    .cornerRadius(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.blue.opacity(0.4), lineWidth: 1)
                    )
                }
            }
        }
    }
}
