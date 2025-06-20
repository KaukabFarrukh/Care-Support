//
//  OxygenPulseView1.swift
//  CareService
//
//  Created by Kamila Ponomarova on 2025-05-22.
//



import SwiftUI

struct OxygenKeyButton: View {
    var key: String
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(key)
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(.blue) // Синие цифры
                .frame(width: 70, height: 60)
                .background(Color.white)
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.gray.opacity(0.4), lineWidth: 1)
                )
        }
    }
}

struct OxygenPulseView1: View {
    @State private var oxygendata = ""
    @State private var pulsedata = ""
    @State private var navigateToNextScreen = false

    var body: some View {
        NavigationStack {
            ZStack {
                Color("background").ignoresSafeArea()
                contentStack
            }
            .navigationBarHidden(true)
        }
    }

    private var contentStack: some View {
        VStack(spacing: 30) {
            titleSection
            inputSection
            keypadSection
            nextButton
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    private var titleSection: some View {
        VStack(spacing: 10) {
            Text("List of Symptoms")
                .font(.system(size: 40, weight: .bold))
                .multilineTextAlignment(.center)
            Text("Oxygen and Pulse")
                .font(.title2)
                .foregroundColor(.secondary)
            Text("Please enter your or the care receiver's oxygen saturation data and pulse")
                .font(.body)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 30)
        }
        .padding(.top, 40)
    }

    private var inputSection: some View {
        HStack(spacing: 60) {
            VStack {
                Text("SpO₂").font(.headline)
                TextField("", text: $oxygendata)
                    .keyboardType(.decimalPad)
                    .multilineTextAlignment(.center)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 120)
                Text("%").font(.subheadline)
            }
            VStack {
                Text("Pulse").font(.headline)
                TextField("", text: $pulsedata)
                    .keyboardType(.decimalPad)
                    .multilineTextAlignment(.center)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: 120)
                Text("per minute").font(.subheadline)
            }
        }
        .padding(.top, 20)
    }

    private var keypadSection: some View {
        VStack(spacing: 12) {
            keypadRow(keys: ["1", "2", "3"])
            keypadRow(keys: ["4", "5", "6"])
            keypadRow(keys: ["7", "8", "9"])
            keypadRow(keys: ["C", "0", "⌫"])
        }
        .padding(.top, 30)
    }

    private func keypadRow(keys: [String]) -> some View {
        HStack(spacing: 16) {
            ForEach(keys, id: \.self) { key in
                OxygenKeyButton(key: key) {
                    handleKeyPress(key)
                }
            }
        }
    }

    private var nextButton: some View {
        NavigationLink(destination: OxygenPulseView2(oxygen: oxygendata, value2: "", pulse: pulsedata), isActive: $navigateToNextScreen) {
            Button("Next") {
                navigateToNextScreen = true
            }
            .font(.headline)
            .foregroundColor(.white)
            .frame(width: 180, height: 50)
            .background(Color.blue)
            .cornerRadius(12)
        }
        .padding(.top, 30)
    }

    private func handleKeyPress(_ key: String) {
        switch key {
        case "⌫":
            if !oxygendata.isEmpty {
                oxygendata.removeLast()
            }
        case "C":
            oxygendata = ""
        default:
            if oxygendata.count < 5 {
                oxygendata.append(key)
            }
        }
    }
}

struct OxygenPulseView1_Previews: PreviewProvider {
    static var previews: some View {
        OxygenPulseView1()
            .previewDevice("iPad Pro (13-inch)")
    }
}
