//
//  BodyTempView1.swift
//  CareService
//
//  Created by Kamila Ponomarova on 2025-05-22.
////
//  

import SwiftUI

struct BodyTemperatureView: View {
    @State private var temperature = ""
    @State private var navigateToNextScreen = false

    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                ZStack {
                    Color("background").ignoresSafeArea()

                    VStack(spacing: 30) {
                        titleSection
                        inputSection
                        keypadSection
                        nextButton(geometry: geometry)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding()
                }
            }
        }
        .navigationDestination(isPresented: $navigateToNextScreen) {
            Frame20View(bodyTemperature: temperature)
        }
    }

    private var titleSection: some View {
        VStack(spacing: 10) {
            Text("List of Symptoms")
                .font(.system(size: 40, weight: .bold))
                .multilineTextAlignment(.center)
            Text("Body Temperature")
                .font(.title2)
                .foregroundColor(.secondary)
            Text("Please enter your or the care receiver's body temperature")
                .font(.body)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 30)
        }
        .padding(.top, 40)
    }

    private var inputSection: some View {
        VStack(spacing: 8) {
            TextField("", text: $temperature)
                .keyboardType(.decimalPad)
                .multilineTextAlignment(.center)
                .textFieldStyle(.roundedBorder)
                .frame(width: 120)
            Text("°C")
                .font(.subheadline)
        }
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
                KeyButton(key: key) {
                    handleKeyPress(key)
                }
            }
        }
    }

    private func nextButton(geometry: GeometryProxy) -> some View {
        Button("Next") {
            navigateToNextScreen = true
        }
        .font(.headline)
        .foregroundColor(.white)
        .frame(width: min(geometry.size.width * 0.4, 150), height: 50)
        .background(Color.blue)
        .cornerRadius(12)
        .padding(.top, 30)
    }

    private func handleKeyPress(_ key: String) {
        switch key {
        case "⌫":
            if !temperature.isEmpty {
                temperature.removeLast()
            }
        case "C":
            temperature = ""
        default:
            if temperature.count < 5 {
                temperature.append(key)
            }
        }
    }
}

struct KeyButton: View {
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

struct BodyTemperatureView_Previews: PreviewProvider {
    static var previews: some View {
        BodyTemperatureView()
            .previewDevice("iPad Pro (13-inch)")
    }
}
