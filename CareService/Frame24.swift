//
//  Frame24.swift
//  CareService
//
//  Created by Kamila Ponomarova on 2025-05-22.
//



import SwiftUI

struct Frame24View: View {
    @State private var selectedCategory: String?

    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                VStack(spacing: 30) {
                    Spacer(minLength: 60)

                    Text("Library")
                        .font(.system(size: 40, weight: .bold))
                        .padding(.top, 20)

                    Text("Here you can find links to helpful articles on caring for elderly or sick persons.")
                        .font(.body)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 40)

                    VStack(spacing: 20) {
                        NavigationLink(
                            destination: LinksListView(category: "Comfort and Safety", links: comfortAndSafetyLinks),
                            tag: "Comfort and Safety",
                            selection: $selectedCategory
                        ) {
                            Button("Comfort and Safety") {
                                selectedCategory = "Comfort and Safety"
                            }
                            .buttonStyle(Frame24ButtonStyle())
                        }

                        NavigationLink(
                            destination: LinksListView(category: "Hygiene", links: hygieneLinks),
                            tag: "Hygiene",
                            selection: $selectedCategory
                        ) {
                            Button("Hygiene") {
                                selectedCategory = "Hygiene"
                            }
                            .buttonStyle(Frame24ButtonStyle())
                        }
                    }
                    .frame(maxWidth: min(geometry.size.width * 0.8, 500))

                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color("background"))
                .ignoresSafeArea()
            }
        }
    }

    private var comfortAndSafetyLinks: [String] {
        [
            "https://www.agingcare.com/articles/tips-for-keeping-seniors-safe-at-home-140217.htm",
            "https://www.healthline.com/health/safe-living-for-elderly"
        ]
    }

    private var hygieneLinks: [String] {
        [
            "https://www.caregiver.org/resource/personal-hygiene/",
            "https://www.homecareassistance.com/blog/importance-of-hygiene-for-seniors"
        ]
    }
}

struct Frame24ButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .frame(height: 50)
            .frame(maxWidth: .infinity)
            .background(Color.blue)
            .cornerRadius(12)
            .padding(.horizontal)
            .scaleEffect(configuration.isPressed ? 0.96 : 1.0)
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }
}

struct Frame24View_Previews: PreviewProvider {
    static var previews: some View {
        Frame24View()
            .previewDevice("iPad Pro (13-inch)")
    }
}
