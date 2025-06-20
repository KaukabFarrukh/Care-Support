//
//  LinksListView.swift
//  CareService
//
//  Created by Kamila Ponomarova on 2025-05-22.
//



import SwiftUI

struct LinksListView: View {
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

                            Text("Here are some helpful articles:")
                                .font(.title3)
                                .multilineTextAlignment(.center)
                                .foregroundColor(.secondary)
                                .padding(.horizontal)
                                .frame(maxWidth: 600)

                            VStack(spacing: 20) {
                                ForEach(links, id: \.self) { link in
                                    LinkCardView(link: link)
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

struct LinkCardView: View {
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

// MARK: - Preview

struct LinksListView_Previews: PreviewProvider {
    static var previews: some View {
        LinksListView(
            category: "Comfort and Safety",
            links: [
                "https://www.agingcare.com/articles/tips-for-keeping-seniors-safe-at-home-140217.htm",
                "https://www.healthline.com/health/safe-living-for-elderly"
            ]
        )
        .previewDevice("iPad Pro (13-inch)")
    }
}
