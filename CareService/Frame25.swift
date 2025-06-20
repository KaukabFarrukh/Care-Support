//
//  Frame25.swift
//  CareService
//
//  Created by Kamila Ponomarova on 2025-05-22.
//



import SwiftUI

struct Frame25View: View {
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

                            // Описание
                            Text("Here you can find links to helpful articles on caring for elderly or sick persons.")
                                .font(.body)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal)
                                .frame(maxWidth: 600)

                            // Кнопки навигации
                            VStack(spacing: 20) {
                                NavigationLink(
                                    destination: LinksListView2(category: "Intimate Hygiene", links: intimatehygieneLinks),
                                    tag: "Intimate Hygiene",
                                    selection: $selectedCategory
                                ) {
                                    Button("Intimate Hygiene") {
                                        selectedCategory = "Intimate Hygiene"
                                    }
                                    .buttonStyle(Frame25ButtonStyle())
                                }

                                NavigationLink(
                                    destination: LinksListView2(category: "Taking Medications", links: takingmedicationsLinks),
                                    tag: "Taking Medications",
                                    selection: $selectedCategory
                                ) {
                                    Button("Taking Medications") {
                                        selectedCategory = "Taking Medications"
                                    }
                                    .buttonStyle(Frame25ButtonStyle())
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

    private var intimatehygieneLinks: [String] {
        [
            "https://lab-seid.com/six-tips-keep-hygiene-intimate-prevent-infections/?lang=en",
            "https://www.cumlaudelab.com/en/how-to-choose-the-best-intimate-hygiene-product/"
        ]
    }

    private var takingmedicationsLinks: [String] {
        [
            "https://www.nia.nih.gov/health/medicines-and-medication-management/taking-medicines-safely-you-age",
            "https://www.nia.nih.gov/news/dangers-polypharmacy-and-case-deprescribing-older-adults"
        ]
    }
}

// MARK: - Стилизация кнопок

struct Frame25ButtonStyle: ButtonStyle {
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

struct Frame25View_Previews: PreviewProvider {
    static var previews: some View {
        Frame25View()
            .previewDevice("iPad Pro (13-inch)")
    }
}
