//
//  Fillinginformation.swift
//  CareSupport
//
//  Created by Kaukab Farrukh on 2025-05-22.
//

import SwiftUI

struct Fillinginformation1: View {
    @State var firebase = Firebasecode()
    @State private var showAlert = true
    @Environment(\.dismiss) private var dismiss     // 👈 for going back to CareHomeView

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

            VStack(spacing: 24) {
                Text("List of symptoms")
                    .font(.title2.weight(.bold))
                    .padding(.top, 24)

                Text("Fill in measurements for weight, blood pressure, oxygen and pulse, temperature and sugar level. This information helps to create a better care plan.")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 24)

                VStack(alignment: .leading, spacing: 16) {
                    symptomButton(label: "Weight", destination: BodyWeightView1())
                    symptomButton(label: "Pressure", destination: BloodPressureView1())
                    symptomButton(label: "Oxygen & pulse", destination: OxygenPulseView1())
                    symptomButton(label: "Body temperature", destination: BodyTemperatureView())
                    symptomButton(label: "Sugar level", destination: Frame21View())
                }
                .frame(maxWidth: 340)

                Spacer()

                // 👇 NEW: Back to home (CareHomeView)
                Button(action: {
                    dismiss()      // goes back to CareHomeView
                }) {
                    Text("Back to home")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .frame(height: 48)
                        .background(Color(red: 0.16, green: 0.70, blue: 0.36))
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                }
                .padding(.horizontal, 40)
                .padding(.bottom, 24)
            }
            .padding()
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Notice"),
                message: Text("The information you specify about yourself or your care receiver in these fields will be saved for the purposes of determining optimal procedures of care."),
                dismissButton: .default(Text("OK"))
            )
        }
        .navigationTitle("Symptom diary")
        .navigationBarTitleDisplayMode(.inline)
    }

    @ViewBuilder
    private func symptomButton<Destination: View>(label: String, destination: Destination) -> some View {
        NavigationLink(destination: destination) {
            HStack {
                Text(label)
                    .foregroundColor(.primary)
                    .fontWeight(.medium)
                Spacer()
                Image(systemName: "plus.circle")
                    .font(.title3)
                    .foregroundColor(Color(red: 0.10, green: 0.60, blue: 0.55))
            }
            .padding()
            .background(Color.white)
            .cornerRadius(12)
            .shadow(color: .black.opacity(0.06), radius: 6, x: 0, y: 3)
        }
    }
}

#Preview {
    NavigationStack { Fillinginformation1() }
}
