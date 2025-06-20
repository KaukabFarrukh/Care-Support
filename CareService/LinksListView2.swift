//
//  LinksListView2.swift
//  CareService
//
//  Created by Kamila Ponomarova on 2025-05-22.
//



import SwiftUI

struct LinksListView2: View {
    var category: String
    var links: [String]

    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                ZStack {
                    Color("background")
                        .ignoresSafeArea()

                    ScrollView {
                        VStack(spacing: 32) {
                            Text(category)
                                .font(.largeTitle.bold())
                                .multilineTextAlignment(.center)
                                .padding(.top, 60)
                                .frame(maxWidth: .infinity)

                            Text("Here are some helpful articles:")
                                .font(.title3)
                                .foregroundColor(.secondary)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal)
                                .frame(maxWidth: 600)

                            VStack(spacing: 20) {
                                ForEach(links, id: \.self) { link in
                                    LinkCardView2(link: link)
                                }
                            }
                            .padding(.horizontal)
                            .frame(maxWidth: 600)

                            Spacer(minLength: 60)
                        }
                        .frame(minHeight: geometry.size.height)
                        .frame(maxWidth: .infinity)
                    }
                }
            }
        }
    }
}

struct LinkCardView2: View {
    let link: String

    var body: some View {
        Button(action: {
            openURL(link)
        }) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(link)
                        .font(.body)
                        .foregroundColor(.blue)
                        .underline()
                        .lineLimit(2)
                        .truncationMode(.middle)
                }

                Spacer()

                Image(systemName: "arrow.up.right.circle.fill")
                    .foregroundColor(.blue)
                    .font(.title2)
            }
            .padding()
            .background(Color.white)
            .cornerRadius(12)
            .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
        }
    }

    private func openURL(_ urlString: String) {
        if let url = URL(string: urlString) {
            UIApplication.shared.open(url)
        }
    }
}



struct LinksListView2_Previews: PreviewProvider {
    static var previews: some View {
        LinksListView2(
            category: "Intimate Hygiene",
            links: [
                "https://www.cumlaudelab.com/en/how-to-choose-the-best-intimate-hygiene-product/",
                "https://lab-seid.com/six-tips-keep-hygiene-intimate-prevent-infections/?lang=en"
            ]
        )
        .previewDevice("iPad Pro (13-inch)")
    }
}
