//
//  CareTasksChecklistView.swift
//  CareService
//
//  Created by Kaukab Farrukh on 2025-11-17.
//

import SwiftUI

struct CareTasksChecklistView: View {
    struct CareTask: Identifiable {
        let id = UUID()
        let title: String
        let detail: String
        var done: Bool
    }

    @State private var tasks: [CareTask] = [
        CareTask(title: "Take medication",
                 detail: "Follow the dose prescribed by your doctor.",
                 done: false),
        CareTask(title: "Drink water",
                 detail: "Aim for 6–8 glasses during the day.",
                 done: false),
        CareTask(title: "Short walk / movement",
                 detail: "Move safely for a few minutes if possible.",
                 done: false),
        CareTask(title: "Rest & breathing break",
                 detail: "Sit comfortably and breathe slowly for 5 minutes.",
                 done: false)
    ]

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [
                    Color("background"),
                    Color.white
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 16) {
                Text("Daily care checklist")
                    .font(.title2.weight(.bold))
                    .padding(.top, 16)

                Text("Use this checklist together with your caregiver to remember simple daily care steps.")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)

                List {
                    ForEach($tasks) { $task in
                        HStack(alignment: .top, spacing: 12) {
                            Button {
                                task.done.toggle()
                            } label: {
                                Image(systemName: task.done ? "checkmark.circle.fill" : "circle")
                                    .font(.title3)
                                    .foregroundColor(task.done
                                                     ? Color(red: 0.16, green: 0.70, blue: 0.36)
                                                     : .gray)
                            }
                            VStack(alignment: .leading, spacing: 4) {
                                Text(task.title)
                                    .font(.headline)
                                    .strikethrough(task.done, color: .gray)
                                Text(task.detail)
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                        }
                        .padding(.vertical, 4)
                    }
                }
                .listStyle(.insetGrouped)

                Spacer()
            }
        }
        .navigationTitle("Care checklist")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack { CareTasksChecklistView() }
}
