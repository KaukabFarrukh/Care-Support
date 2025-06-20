//
//  GeneralinformationView2.swift
//  CareService
//
//  Created by Kamila Ponomarova on 2025-05-22.
//



import SwiftUI

struct GeneralinformationIView2: View {
    @State var firebase = Firebasecode()
    @State var navigateToSurvey12 = false

    var body: some View {
        GeometryReader { geometry in
            NavigationStack {
                ZStack {
                    Color("background").ignoresSafeArea()

                    VStack(spacing: 20) {
                        Text("This App is about")
                            .font(.title)
                            .fontWeight(.bold)
                            .padding(.top, 20)

                        Button(action: {
                            firebase.userLogout()
                        }) {
                            Text("Sign Out")
                                .foregroundColor(.blue)
                        }

                        Spacer()

                        Text("You and Me")
                            .font(.largeTitle)
                            .italic()
                            .foregroundColor(.blue)
                            .padding()

                        Text("This app is an efficient assistant in caring for elderly or sick persons. After the registration step, you need to complete a survey that consists of 4 questions. Your answers will help the app in making an appropriate care plan you can use in the future. Besides, the app includes such features as a symptom diary and a library. All recommendations and articles are written by experts.")
                            .font(.body)
                            .multilineTextAlignment(.center)
                            .padding()
                            .frame(maxWidth: geometry.size.width * 0.8)

                        Spacer()

                        Button(action: {
                            navigateToSurvey12 = true
                        }) {
                            Text("Next")
                                .font(.headline)
                                .foregroundColor(.blue)
                                .frame(width: 120, height: 50)
                                .background(Color.white)
                                .cornerRadius(10)
                                .shadow(radius: 5)
                        }
                        .navigationDestination(isPresented: $navigateToSurvey12) {
                            Survey12()
                        }

                        Spacer()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .padding()
                }
                .navigationTitle("General information")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

#Preview {
    GeneralinformationIView2()
}
