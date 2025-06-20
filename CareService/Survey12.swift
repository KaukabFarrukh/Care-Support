//
//  Survey12.swift
//  CareService
//
//  Created by Kamila Ponomarova on 2025-05-22.
//



import SwiftUI

struct Survey12: View {
    @State private var name: String = ""
    @State private var dateOfBirth: Date = Date()
    @State private var gender: String = ""
    @State private var showAlert = false
    @State private var navigateToNext = false

    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                ZStack {
                    Color("background")
                        .ignoresSafeArea()

                    VStack(spacing: 20) {
                        Text("Survey 1")
                            .font(.title)
                            .padding(.top, 40)

                        VStack(alignment: .leading, spacing: 15) {
                            Text("1. What is your care receiver's name?")
                                .font(.headline)
                            TextField("Enter name", text: $name)
                                .textFieldStyle(RoundedBorderTextFieldStyle())

                            Text("2. What is the care receiver's date of birth?")
                                .font(.headline)
                            DatePicker("Select date", selection: $dateOfBirth, displayedComponents: .date)
                                .datePickerStyle(GraphicalDatePickerStyle())

                            Text("3. Choose your gender:")
                                .font(.headline)
                            Picker("Gender", selection: $gender) {
                                Text("Male").tag("Male")
                                Text("Female").tag("Female")
                            }
                            .pickerStyle(SegmentedPickerStyle())

                            Button("Save") {
                                saveData()
                                showAlert = true
                            }
                            .alert(isPresented: $showAlert) {
                                Alert(title: Text("Saved"),
                                      message: Text("Your information has been saved."),
                                      dismissButton: .default(Text("OK")))
                            }
                            .frame(maxWidth: .infinity, minHeight: 44)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)

                            Button("Next") {
                                navigateToNext = true
                            }
                            .frame(maxWidth: .infinity, minHeight: 44)
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                        }
                        .frame(width: geometry.size.width * 0.8)
                        .padding()

                        Spacer()
                    }
                    .frame(width: geometry.size.width, height: geometry.size.height)
                }
            }
            .navigationDestination(isPresented: $navigateToNext) {
                Survey3()
            }
        }
    }

    private func saveData() {
        UserDefaults.standard.set(name, forKey: "SavedName")
        UserDefaults.standard.set(gender, forKey: "SavedGender")
        UserDefaults.standard.set(dateOfBirth, forKey: "SavedDOB")
    }
}

#Preview {
    Survey12()
}
