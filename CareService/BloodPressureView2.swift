//
//  BloodPressureView2.swift
//  CareService
//
//  Created by Kamila Ponomarova on 2025-05-22.
//

//
//  

import SwiftUI

struct BloodPressureView2: View {
    var systolic: String
    var diastolic: String

    @State private var bloodPressureResult = ""
    @State private var showConfirmation = false

    @State private var noteworthyMeasure: String = ""
    @State private var currentTime: String = ""
    @State private var notice: String = ""
    @State private var navigateToNextScreen = false

    var body: some View {
        GeometryReader { geometry in
            NavigationStack {
                VStack(spacing: 20) {
                    Text("List of symptoms")
                        .font(.largeTitle)
                        .bold()

                    Text("Blood pressure is...")
                        .font(.title3)

                    Text("\(systolic) / \(diastolic)")
                        .font(.largeTitle)
                        .bold()
                        .onAppear {
                            bloodPressureResult = "\(systolic) / \(diastolic)"
                            updateCurrentTime()
                        }

                    HStack(spacing: 10) {
                        Text(currentTime)
                            .font(.headline)
                            .padding()
                            .frame(width: geometry.size.width * 0.3, height: 40)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(8)

                        Button("TODAY") {
                            updateCurrentTime()
                        }
                        .frame(width: geometry.size.width * 0.3, height: 40)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                    }

                    VStack(alignment: .leading, spacing: 10) {
                        ForEach(["Body position", "Arm", "Irregular pulse"], id: \.self) { option in
                            Button(action: {
                                noteworthyMeasure = option
                            }) {
                                HStack {
                                    Image(systemName: noteworthyMeasure == option ? "checkmark.circle.fill" : "circle")
                                        .foregroundColor(noteworthyMeasure == option ? .blue : .gray)
                                    Text(option)
                                }
                            }
                        }
                    }
                    .padding()

                    TextField("Enter notice", text: $notice)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: geometry.size.width * 0.7)

                    Button("Save") {
                        saveInformation()
                        showConfirmation = true
                    }
                    .alert(isPresented: $showConfirmation) {
                        Alert(title: Text("Saved"), message: Text("Your information has been saved."), dismissButton: .default(Text("OK")))
                    }
                    .foregroundColor(.white)
                    .frame(width: geometry.size.width * 0.4, height: 44)
                    .background(Color.blue)
                    .cornerRadius(8)

                    Button("Next") {
                        navigateToNextScreen = true
                    }
                    .foregroundColor(.white)
                    .frame(width: geometry.size.width * 0.4, height: 44)
                    .background(Color.green)
                    .cornerRadius(8)
                    .navigationDestination(isPresented: $navigateToNextScreen) {
                        Frame23View()
                    }
                }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color("background"))
                .ignoresSafeArea()
            }
        }
    }

    private func updateCurrentTime() {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        currentTime = formatter.string(from: Date())
    }

    private func saveInformation() {
        UserDefaults.standard.set(bloodPressureResult, forKey: "savedBloodPressure")
        UserDefaults.standard.set(noteworthyMeasure, forKey: "savedNoteworthyMeasure")
        UserDefaults.standard.set(notice, forKey: "savedNotice")
    }
}

struct BloodPressureView2_Previews: PreviewProvider {
    static var previews: some View {
        BloodPressureView2(systolic: "90", diastolic: "60")
    }
}
