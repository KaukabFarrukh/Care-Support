//
//  ContentView.swift
//  CareSupport
//
//  Created by Kaukab Farrukh on 2025-05-22.
//
//

import SwiftUI
import Firebase
import FirebaseAuth

struct ContentView: View {
    var body: some View {
        NavigationStack {
            StartPageView()     // 👈 Always the entry point
        }
    }
}

#Preview {
    ContentView()
}
