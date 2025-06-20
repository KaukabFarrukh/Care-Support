//
//  Frame21.swift
//  CareService
//
//  Created by Kamila Ponomarova on 2025-05-22.
//

import SwiftUI

struct Frame21View: View {
    @State private var enteredValue: String = ""
    @State private var navigateToNextScreen = false
    @State private var sugarLevel = ""

    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                ZStack {
                    Color("background").ignoresSafeArea()

                    VStack(spacing: 20) {
                        titleSection
                        inputSection
                        keypadSection

                        Button("Next") {
                            sugarLevel = enteredValue
                            navigateToNextScreen = true
                        }
                        .foregroundColor(.white)
                        .frame(width: min(geometry.size.width * 0.4, 150), height: 44)
                        .background(Color.blue)
                        .cornerRadius(8)
                        .padding(.top, 20)

                        NavigationLink(
                            destination: Frame22View(bloodSugarLevel: $sugarLevel),
                            isActive: $navigateToNextScreen
                        ) {
                            EmptyView()
                        }
                        .hidden()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding()
                }
            }
        }
    }

    private var titleSection: some View {
        VStack(spacing: 8) {
            Text("List of symptoms")
                .font(.largeTitle)
                .bold()
            Text("Blood sugar level")
                .font(.headline)
            Text("Please enter your or your care receiver's blood sugar level")
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 30)
        }
        .padding(.top, 20)
    }

    private var inputSection: some View {
        VStack(spacing: 12) {
            Text(enteredValue)
                .font(.title2)
                .padding()
                .frame(width: 200)
                .background(Color.white)
                .cornerRadius(8)
                .shadow(radius: 2)
        }
    }

    private var keypadSection: some View {
        VStack(spacing: 10) {
            keypadRow(keys: ["1", "2", "3"])
            keypadRow(keys: ["4", "5", "6"])
            keypadRow(keys: ["7", "8", "9"])
            keypadRow(keys: ["C", "0", "⌫"])
        }
    }

    private func keypadRow(keys: [String]) -> some View {
        HStack(spacing: 10) {
            ForEach(keys, id: \.self) { key in
                NumberPadButton(key: key) {
                    handleKeyPress(key)
                }
            }
        }
    }

    private func handleKeyPress(_ key: String) {
        switch key {
        case "⌫":
            if !enteredValue.isEmpty {
                enteredValue.removeLast()
            }
        case "C":
            enteredValue = ""
        default:
            if enteredValue.count < 5 {
                enteredValue.append(key)
            }
        }
    }
}

struct NumberPadButton: View {
    let key: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(key)
                .frame(width: 60, height: 60)
                .background(Color.white)
                .foregroundColor(.blue)
                .cornerRadius(8)
                .font(.title)
        }
    }
}

struct Frame21View_Previews: PreviewProvider {
    static var previews: some View {
        Frame21View()
            .previewDevice("iPad Pro (13-inch)")
    }
}
