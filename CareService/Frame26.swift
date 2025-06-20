//
//  //
//  Frame26View.swift
//  You and me project
//
//  Created by Kaukab Farrukh on 2025-02-05.
//

import SwiftUI

struct Frame26View: View {
    @State private var selectedCategory: String?

    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                ZStack {
                    Color("background")
                        .ignoresSafeArea()

                    ScrollView {
                        VStack(spacing: 32) {
                            // Заголовок
                            Text("Library")
                                .font(.largeTitle.bold())
                                .padding(.top, 60)

                            // Подзаголовок
                            Text("Here you can find links to helpful articles on caring for elderly or sick persons.")
                                .font(.body)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal)
                                .frame(maxWidth: 600)

                            // Кнопки
                            VStack(spacing: 20) {
                                NavigationLink(
                                    destination: LinksListView3(category: "Nutrition", links: nutritionLinks),
                                    tag: "Nutrition",
                                    selection: $selectedCategory
                                ) {
                                    Button("Nutrition") {
                                        selectedCategory = "Nutrition"
                                    }
                                    .buttonStyle(Frame26ButtonStyle())
                                }

                                NavigationLink(
                                    destination: LinksListView3(category: "Benefits of Walking", links: benefitsofwalkingLinks),
                                    tag: "Benefits of Walking",
                                    selection: $selectedCategory
                                ) {
                                    Button("Benefits of Walking") {
                                        selectedCategory = "Benefits of Walking"
                                    }
                                    .buttonStyle(Frame26ButtonStyle())
                                }
                            }

                            Spacer()
                        }
                        .padding(.horizontal)
                        .frame(minHeight: geometry.size.height)
                        .frame(maxWidth: 600)
                        .frame(maxWidth: .infinity)
                    }
                }
            }
        }
    }

    // MARK: - Ссылки

    private var nutritionLinks: [String] {
        [
            "https://www.nia.nih.gov/health/healthy-eating-nutrition-and-diet/healthy-meal-planning-tips-older-adults",
            "https://www.nia.nih.gov/health/healthy-eating-nutrition-and-diet/how-read-food-and-beverage-labels"
        ]
    }

    private var benefitsofwalkingLinks: [String] {
        [
            "https://www.nia.nih.gov/health/exercise-and-physical-activity/real-life-benefits-exercise-and-physical-activity",
            "https://www.nia.nih.gov/news/leisure-activities-may-improve-longevity-older-adults"
        ]
    }
}

// MARK: - Стилизация кнопок

struct Frame26ButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.white)
            .font(.headline)
            .padding()
            .frame(height: 50)
            .frame(maxWidth: .infinity)
            .background(Color.blue)
            .cornerRadius(12)
            .padding(.horizontal, 20)
            .scaleEffect(configuration.isPressed ? 0.97 : 1)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

// MARK: - Превью

struct Frame26View_Previews: PreviewProvider {
    static var previews: some View {
        Frame26View()
            .previewDevice("iPad Pro (13-inch)")
    }
}
