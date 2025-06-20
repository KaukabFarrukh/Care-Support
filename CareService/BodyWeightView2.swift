//
//  BodyWeightView2.swift
//  CareService
//
//  Created by Kamila Ponomarova on 2025-05-22.
//



import SwiftUI

struct BodyWeightView2: View {
    var bodyweight: String // From BodyWeightView1
    @State private var currentTime: String = ""
    @State private var notice: String = ""
    @State private var showConfirmation = false
    @State private var navigateToNextScreen = false

    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                ZStack {
                    Color("background").ignoresSafeArea()

                    VStack(spacing: 20) {
                        Text("List of symptoms")
                            .font(.largeTitle)
                            .bold()
                            .padding(.top, geometry.size.height * 0.1)

                        Text("Body weight is...")
                            .font(.title3)

                        Text("\(bodyweight) kg")
                            .font(.largeTitle)
                            .bold()

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
                            .foregroundColor(.white)
                            .frame(width: geometry.size.width * 0.3, height: 40)
                            .background(Color.blue)
                            .cornerRadius(8)
                        }

                        TextField("Enter notice", text: $notice)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(width: geometry.size.width * 0.6)

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
                        .frame(width: geometry.size.width * 0.4, height: 44)
                        .background(Color.blue)
                        .cornerRadius(8)
                        .padding(.top, 10)

                        Button("Next") {
                            navigateToNextScreen = true
                        }
                        .foregroundColor(.white)
                        .frame(width: geometry.size.width * 0.4, height: 44)
                        .background(Color.green)
                        .cornerRadius(8)
                        .padding(.top, 10)
                        .navigationDestination(isPresented: $navigateToNextScreen) {
                            Frame23View()
                        }

                        Spacer()
                    }
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
            .onAppear {
                updateCurrentTime()
            }
        }
    }

    private func updateCurrentTime() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        currentTime = dateFormatter.string(from: Date())
    }

    private func saveInformation() {
        UserDefaults.standard.set(bodyweight, forKey: "savedWeight")
        UserDefaults.standard.set(notice, forKey: "savedWeightNotice")
    }
}

struct BodyWeightView2_Previews: PreviewProvider {
    static var previews: some View {
        BodyWeightView2(bodyweight: "57.0")
    }
}
