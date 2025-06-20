//
//  OxygenPulseView2.swift
//  CareService
//
//  Created by Kamila Ponomarova on 2025-05-22.
//



import SwiftUI

struct OxygenPulseView2: View {
    var oxygen: String
    var value2: String
    var pulse: String

    @State private var showConfirmation = false
    @State private var oxygenPulseResult = ""
    @State private var currentTime: String = ""
    @State private var notice: String = ""
    @Environment(\.horizontalSizeClass) var sizeClass

    var body: some View {
        NavigationStack {
            ZStack {
                Color("background").ignoresSafeArea()

                ScrollView {
                    VStack(alignment: .center, spacing: 30) {
                        headerSection
                        resultSection
                        timestampSection
                        noticeField
                        saveButton
                        navigationButton
                    }
                    .padding()
                    .frame(maxWidth: 700)
                    .onAppear {
                        updateCurrentTime()
                        oxygenPulseResult = "\(oxygen) / \(value2) / \(pulse)"
                    }
                }
            }
            .navigationTitle("Oxygen & Pulse")
            .navigationBarTitleDisplayMode(.inline)
        }
    }

    private var headerSection: some View {
        VStack(spacing: 8) {
            Text("List of Symptoms")
                .font(.largeTitle)
                .fontWeight(.bold)

            Text("Oxygen and pulse is...")
                .font(.title3)
                .foregroundColor(.secondary)
        }
    }

    private var resultSection: some View {
        Text(oxygenPulseResult)
            .font(.system(size: 34, weight: .bold, design: .rounded))
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.white)
            .cornerRadius(16)
            .shadow(radius: 4)
    }

    private var timestampSection: some View {
        HStack(spacing: 16) {
            Text(currentTime)
                .font(.headline)
                .padding()
                .frame(width: 150)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)

            Button("Today") {
                updateCurrentTime()
            }
            .frame(width: 150, height: 44)
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
        }
    }

    private var noticeField: some View {
        TextField("Enter notice", text: $notice)
            .textFieldStyle(.roundedBorder)
            .padding(.horizontal, 20)
            .frame(maxWidth: 400)
    }

    private var saveButton: some View {
        Button("Save") {
            saveInformation()
            showConfirmation = true
        }
        .alert(isPresented: $showConfirmation) {
            Alert(title: Text("Saved"), message: Text("Your information has been saved."), dismissButton: .default(Text("OK")))
        }
        .foregroundColor(.white)
        .frame(width: 200, height: 50)
        .background(Color.accentColor)
        .cornerRadius(10)
        .shadow(radius: 3)
    }

    private var navigationButton: some View {
        NavigationLink(destination: Frame23View()) {
            Text("Next")
                .font(.headline)
                .foregroundColor(.white)
                .frame(width: 200, height: 50)
                .background(Color.green)
                .cornerRadius(10)
                .shadow(radius: 3)
        }
        .padding(.top, 20)
    }

    private func updateCurrentTime() {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        currentTime = formatter.string(from: Date())
    }

    private func saveInformation() {
        UserDefaults.standard.set(oxygenPulseResult, forKey: "savedWeight")
        UserDefaults.standard.set(notice, forKey: "savedNotice")
    }
}

struct OxygenPulseView2_Previews: PreviewProvider {
    static var previews: some View {
        OxygenPulseView2(oxygen: "95", value2: "78", pulse: "80")
            .previewDevice("iPad Pro (13-inch)")
            .environment(\.colorScheme, .light)
    }
}
