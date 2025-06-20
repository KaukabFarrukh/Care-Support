//
//  RecommendationsView3.swift
//  CareService
//
//  Created by Kamila Ponomarova on 2025-05-22.
//



import SwiftUI

struct RecommendationsView3: View {
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                ZStack {
                    Color("background").ignoresSafeArea()

                    ScrollView {
                        VStack(alignment: .center, spacing: 20) {
                            Text("Recommendations for a person who uses a cane or walkers. The steps described below can be done either by a sick person independently or with the help of an assistant.")
                                .font(.title2)
                                .fontWeight(.heavy)
                                .multilineTextAlignment(.center)
                                .padding()

                            NavigationLink(destination: Frame26View()) {
                                Text("Nutrition")
                                    .font(.headline)
                                    .foregroundColor(.black)
                                    .frame(width: min(geometry.size.width * 0.7, 300), height: 50)
                                    .background(Color.white)
                                    .cornerRadius(15)
                                    .shadow(radius: 5)
                            }

                            Text("A properly balanced diet is one of the main conditions for keeping up health.")
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal)

                            NavigationLink(destination: Frame26View()) {
                                Text("Benefits of walking")
                                    .font(.headline)
                                    .foregroundColor(.black)
                                    .frame(width: min(geometry.size.width * 0.7, 300), height: 50)
                                    .background(Color.white)
                                    .cornerRadius(15)
                                    .shadow(radius: 5)
                            }

                            Text("It's important that the care receiver takes all medications recommended by the doctor strictly at the time they were prescribed.")
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .navigationTitle("Page 3")
                        .navigationBarTitleDisplayMode(.inline)
                    }
                }
            }
        }
    }
}

#Preview {
    RecommendationsView3()
}
