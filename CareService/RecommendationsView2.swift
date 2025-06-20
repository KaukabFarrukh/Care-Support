//
//  RecommendationsView2.swift
//  CareService
//
//  Created by Kamila Ponomarova on 2025-05-22.
//


import SwiftUI

struct RecommendationsView2: View {
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

                            NavigationLink(destination: Frame25View()) {
                                Text("Intimate hygiene")
                                    .font(.headline)
                                    .foregroundColor(.blue)
                                    .frame(width: min(geometry.size.width * 0.7, 300), height: 50)
                                    .background(Color.white)
                                    .cornerRadius(15)
                                    .shadow(radius: 5)
                            }

                            Text("Intimate hygiene plays an extremely important role in the life of a person with diabetes. Make sure you follow all steps.")
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal)

                            NavigationLink(destination: Frame25View()) {
                                Text("Taking medication")
                                    .font(.headline)
                                    .foregroundColor(.blue)
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

                            NavigationLink(destination: RecommendationsView3()) {
                                Text("Next page")
                                    .foregroundColor(.blue)
                                    .frame(width: 120, height: 50)
                                    .background(Color.white)
                                    .cornerRadius(15)
                                    .shadow(radius: 5)
                            }
                            .padding(.top, 10)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .navigationTitle("Page 2")
                        .navigationBarTitleDisplayMode(.inline)
                    }
                }
            }
        }
    }
}

#Preview {
    RecommendationsView2()
}
