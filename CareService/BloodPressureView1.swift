//
//  BloodPressureView1.swift
//  CareService
//
//  Created by Kamila Ponomarova on 2025-05-22.
//

//
//  

import SwiftUI

struct BloodPressureView1: View {
    @State private var systolicdata = ""
    @State private var diastoloedata = ""
    @State private var navigateToNextScreen = false

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
                            navigateToNextScreen = true
                        }
                        .foregroundColor(.white)
                        .frame(width: min(geometry.size.width * 0.4, 150), height: 44)
                        .background(Color.blue)
                        .cornerRadius(8)
                        .padding(.top, 20)

                        // Modern navigation destination
                        .navigationDestination(isPresented: $navigateToNextScreen) {
                            BloodPressureView2(systolic: systolicdata,  diastolic: diastoloedata)
                        }
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding()
                }
            }
        }
    }

    private var titleSection: some View {
        VStack {
            Text("List of symptoms")
                .font(.largeTitle)
                .bold()
            Text("Blood Pressure")
                .font(.headline)
            Text("Please enter your or the care receiver's blood pressure")
                .font(.subheadline)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 30)
        }
        .padding(.top, 20)
    }

    private var inputSection: some View {
        HStack(spacing: 40) {
            VStack {
                Text("Systolic")
                TextField("", text: $systolicdata)
                    .keyboardType(.decimalPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 100)
                Text("mm Hg").font(.headline)
            }
            VStack {
                Text("Diastolic")
                TextField("", text: $diastoloedata)
                    .keyboardType(.decimalPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 100)
                Text("mm Hg").font(.headline)
            }
        }
        .padding(.top, 20)
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
                BloodPressureKeyButton(key: key) {
                    handleKeyPress(key)
                }
            }
        }
    }

    private func handleKeyPress(_ key: String) {
        switch key {
        case "⌫":
            systolicdata = String(systolicdata.dropLast())
        case "C":
            systolicdata = ""
        default:
            if systolicdata.count < 5 && key != "⌫" && key != "C" {
                systolicdata.append(key)
            }
        }
    }
}

struct BloodPressureKeyButton: View {
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

struct BloodPressureView1_Previews: PreviewProvider {
    static var previews: some View {
        BloodPressureView1()
    }
}
