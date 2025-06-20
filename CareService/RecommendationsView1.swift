//
//  RecommendationsView1.swift
//  CareService
//
//  Created by Kamila Ponomarova on 2025-05-22.
//



import SwiftUI
import FirebaseAuth

struct RecommendationsView1: View {
    @State private var firebase = Firebasecode()
    @State private var navigateToSurvey = false
    @State private var navigateToSymptoms = false
    @State private var navigateToComfort = false
    @State private var navigateToHygiene = false
    @State private var navigateToNextPage = false
    @State private var navigateToStart = false

    // Account Deletion States
    @State private var showDeleteAlert = false
    @State private var showReauthSheet = false
    @State private var showFinalConfirmSheet = false
    @State private var showError = false
    @State private var deletionErrorMessage = ""
    @State private var reauthPassword = ""
    @State private var finalConfirmText = ""

    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                ZStack {
                    Color("background").ignoresSafeArea()

                    VStack(spacing: 20) {
                        Text("Recommendations for a person who uses a cane or walkers. The steps described below can be done either by a sick person independently or with the help of an assistant.")
                            .padding()
                            .multilineTextAlignment(.center)
                            .foregroundColor(.black)

                        Text("NOTE: The survey is reserved for registered users! Please ignore otherwise.")
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                            .padding(.horizontal)

                        Button(action: { navigateToSurvey = true }) {
                            Text("Do a survey")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(width: geometry.size.width * 0.6, height: 50)
                                .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .leading, endPoint: .trailing))
                                .cornerRadius(15)
                                .shadow(radius: 5)
                        }

                        Button(action: { navigateToSymptoms = true }) {
                            Text("List of symptoms")
                                .font(.headline)
                                .foregroundColor(.blue)
                                .frame(width: geometry.size.width * 0.6, height: 50)
                                .background(Color.white)
                                .cornerRadius(15)
                                .shadow(radius: 5)
                        }

                        Text("Write the care receiver's symptoms into a diary...")
                            .foregroundColor(.white)
                            .padding(.horizontal)

                        Button(action: { navigateToComfort = true }) {
                            Text("Comfort & safety")
                                .font(.headline)
                                .foregroundColor(.blue)
                                .frame(width: geometry.size.width * 0.6, height: 50)
                                .background(Color.white)
                                .cornerRadius(15)
                                .shadow(radius: 5)
                        }

                        Text("Check whether the care receiver's in comfortable condition and feels safe. Make sure you follow all steps.")
                            .foregroundColor(.white)
                            .padding(.horizontal)

                        Button(action: { navigateToHygiene = true }) {
                            Text("Hygiene")
                                .font(.headline)
                                .foregroundColor(.blue)
                                .frame(width: geometry.size.width * 0.6, height: 50)
                                .background(Color.white)
                                .cornerRadius(15)
                                .shadow(radius: 5)
                        }

                        Text("Hygiene plays an extremely important role in the life of a person with diabetes. Make sure you follow all steps.")
                            .foregroundColor(.white)
                            .padding(.horizontal)

                        Button(action: { navigateToNextPage = true }) {
                            Text("Next page")
                                .font(.headline)
                                .foregroundColor(.blue)
                                .frame(width: 140, height: 50)
                                .background(Color.white)
                                .cornerRadius(15)
                                .shadow(radius: 5)
                        }
                        .padding(.top, 10)

                        // Logout button
                        Button(action: {
                            firebase.userLogout()
                        }) {
                            Text("Logout")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(width: 100, height: 40)
                                .background(LinearGradient(gradient: Gradient(colors: [Color.purple, Color.blue]), startPoint: .top, endPoint: .bottom))
                                .cornerRadius(15)
                                .shadow(radius: 5)
                        }

                        // Delete Account button
                        Button(action: {
                            showDeleteAlert = true
                        }) {
                            Text("Delete Account")
                                .font(.headline)
                                .foregroundColor(.white)
                                .frame(width: 180, height: 40)
                                .background(Color.red)
                                .cornerRadius(15)
                                .shadow(radius: 5)
                        }
                        .padding(.top, 10)

                        if showError {
                            Text(deletionErrorMessage)
                                .foregroundColor(.red)
                                .multilineTextAlignment(.center)
                                .padding()
                        }

                        Spacer()
                    }
                    .frame(width: geometry.size.width * 0.8)
                    .padding()
                    .alert(isPresented: $showDeleteAlert) {
                        Alert(
                            title: Text("Delete Account"),
                            message: Text("Are you sure you want to permanently delete your account? This action cannot be undone."),
                            primaryButton: .destructive(Text("Continue")) {
                                showFinalConfirmSheet = true
                            },
                            secondaryButton: .cancel()
                        )
                    }
                    .sheet(isPresented: $showFinalConfirmSheet) {
                        VStack(spacing: 20) {
                            Text("Type DELETE to confirm")
                                .font(.headline)

                            TextField("Type DELETE", text: $finalConfirmText)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding()

                            Button("Delete Now") {
                                if finalConfirmText == "DELETE" {
                                    deleteAccount()
                                } else {
                                    showError = true
                                    deletionErrorMessage = "Input didn't match. Please type DELETE."
                                }
                                showFinalConfirmSheet = false
                            }
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.red)
                            .cornerRadius(10)

                            Button("Cancel") {
                                showFinalConfirmSheet = false
                                finalConfirmText = ""
                            }
                            .foregroundColor(.gray)
                        }
                        .padding()
                    }
                    .sheet(isPresented: $showReauthSheet) {
                        VStack(spacing: 20) {
                            Text("Re-enter Password")
                                .font(.headline)

                            SecureField("Password", text: $reauthPassword)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding()

                            Button("Confirm") {
                                showReauthSheet = false
                                reauthenticateAndDelete(password: reauthPassword)
                            }
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)

                            Button("Cancel") {
                                showReauthSheet = false
                                reauthPassword = ""
                            }
                            .foregroundColor(.gray)
                        }
                        .padding()
                    }
                    .navigationDestination(isPresented: $navigateToSurvey) { Survey12() }
                    .navigationDestination(isPresented: $navigateToSymptoms) { Fillinginformation1() }
                    .navigationDestination(isPresented: $navigateToComfort) { Frame24View() }
                    .navigationDestination(isPresented: $navigateToHygiene) { Frame24View() }
                    .navigationDestination(isPresented: $navigateToNextPage) { RecommendationsView2() }
                    .navigationDestination(isPresented: $navigateToStart) { StartPageView() }
                }
            }
        }
    }

    func deleteAccount() {
        guard let user = Auth.auth().currentUser else {
            showError = true
            deletionErrorMessage = "No user is currently logged in."
            return
        }

        user.delete { error in
            if let error = error as NSError? {
                if error.code == AuthErrorCode.requiresRecentLogin.rawValue {
                    showReauthSheet = true
                } else {
                    showError = true
                    deletionErrorMessage = "Error: \(error.localizedDescription)"
                }
            } else {
                do {
                    try Auth.auth().signOut()
                    navigateToStart = true
                } catch {
                    showError = true
                    deletionErrorMessage = "Account deleted, but sign-out failed."
                }
            }
        }
    }

    func reauthenticateAndDelete(password: String) {
        guard let user = Auth.auth().currentUser,
              let email = user.email else {
            showError = true
            deletionErrorMessage = "Missing user or email."
            return
        }

        let credential = EmailAuthProvider.credential(withEmail: email, password: password)

        user.reauthenticate(with: credential) { result, error in
            if let error = error {
                showError = true
                deletionErrorMessage = "Reauthentication failed: \(error.localizedDescription)"
            } else {
                deleteAccount()
            }
        }
    }
}

#Preview {
    RecommendationsView1()
}
