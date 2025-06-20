//
//  StartPageView.swift
//  CareService
//
//  Created by Kamila Ponomarova on 2025-05-22.
//

import SwiftUI

struct StartPageView: View {
    @State private var showAlert = false

    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                ZStack {
                    Color("background")
                        .ignoresSafeArea()

                    VStack(spacing: 30) {
                        // Logo + circle
                        ZStack {
                            Circle()
                                .fill(Color.white.opacity(0.2))
                                .frame(width: geometry.size.width * 0.3, height: geometry.size.width * 0.3)
                                .shadow(color: .blue.opacity(0.5), radius: 20)

                            Image(systemName: "heart.text.square.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: geometry.size.width * 0.2, height: geometry.size.width * 0.2)
                                .foregroundColor(.blue)
                                .shadow(color: .white, radius: 10)
                        }
                        .padding(.top, 40)

                        Text("You and Me")
                            .font(.largeTitle)
                            .italic()
                            .fontWeight(.bold)
                            .foregroundColor(.blue)
                            .shadow(color: .blue.opacity(0.5), radius: 10, x: 0, y: 5)

                        Text("Elderly Care Service")
                            .font(.headline)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 10)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(20)
                            .shadow(color: .blue.opacity(0.4), radius: 8, x: 0, y: 5)

                        Button("General Information") {
                            showAlert = true
                        }
                        .alert(isPresented: $showAlert) {
                            Alert(
                                title: Text("General Information"),
                                message: Text("This app is an efficient assistant in caring for elderly or sick persons. After the registration step, you need to complete a survey that consists of 4 questions. Your answers will help the app in making an appropriate care plan you can use in the future. Besides, the app includes such features as a symptom diary and a library. All recommendations and articles are written by experts."),
                                dismissButton: .default(Text("OK"))
                            )
                        }
                        .font(.body)
                        .padding()

                        NavigationLink(destination: WelcomePage()) {
                            Text("Start")
                                .font(.headline)
                                .foregroundColor(.blue)
                                .frame(width: 120, height: 50)
                                .background(Color.white)
                                .cornerRadius(25)
                                .shadow(color: .blue.opacity(0.4), radius: 10, x: 0, y: 5)
                        }
                        .padding(.top, 20)

                        Spacer()
                    }
                    .frame(width: geometry.size.width * 0.8)
                    .padding()
                }
            }
        }
    }
}

#Preview {
    StartPageView()
}
