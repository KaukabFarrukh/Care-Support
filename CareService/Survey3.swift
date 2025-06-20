//
//  Survey3.swift
//  CareService
//
//  Created by Kamila Ponomarova on 2025-05-22.
//



import SwiftUI

struct CheckboxItem {
    var name: String
    var isChecked: Bool
}

struct CheckboxView: View {
    @Binding var item: CheckboxItem

    var body: some View {
        HStack {
            Text(item.name)
            Spacer()
            Image(systemName: item.isChecked ? "checkmark.circle.fill" : "circle")
                .foregroundColor(item.isChecked ? .green : .gray)
                .font(.system(size: 22))
                .onTapGesture {
                    item.isChecked.toggle()
                }
        }
        .padding(.vertical, 5)
    }
}

struct Survey3: View {
    @State private var items = [
        CheckboxItem(name: "moves with the help of walkers", isChecked: false),
        CheckboxItem(name: "can not walk but can sit without support", isChecked: false),
        CheckboxItem(name: "always lies", isChecked: false),
    ]
    @State private var navigateToRecommendations = false

    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                ZStack {
                    Color("background").ignoresSafeArea()

                    VStack(alignment: .center, spacing: 20) {
                        Text("4. How does the care receiver move?")
                            .font(.headline)
                            .padding(.top, 40)

                        List {
                            ForEach($items, id: \.name) { $item in
                                CheckboxView(item: $item)
                            }
                        }
                        .listStyle(.plain)
                        .frame(height: geometry.size.height * 0.4)

                        Spacer()

                        Button(action: {
                            navigateToRecommendations = true
                        }) {
                            Text("Finish and go back to recommendations")
                                .font(.headline)
                                .foregroundColor(.blue)
                                .frame(width: min(geometry.size.width * 0.6, 250), height: 50)
                                .background(Color.white)
                                .cornerRadius(15)
                                .shadow(radius: 5)
                        }

                        Spacer()
                    }
                    .frame(width: geometry.size.width * 0.9)
                    .navigationTitle("Survey 2")
                    .navigationBarTitleDisplayMode(.inline)
                    .navigationDestination(isPresented: $navigateToRecommendations) {
                        RecommendationsView1()
                    }
                }
            }
        }
    }
}

#Preview {
    Survey3()
}
