//
//  LogInView.swift
//  CareService
//
//  Created by Kamila Ponomarova on 2025-05-22.
//


import SwiftUI
import FirebaseAuth

struct SecureTextField: View {
    @State private var isSecureField: Bool = true
    @Binding var text: String

    var body: some View {
        HStack {
            if isSecureField {
                SecureField("Password", text: $text)
            } else {
                TextField("Password", text: $text)
            }

            Button(action: {
                isSecureField.toggle()
            }) {
                Image(systemName: isSecureField ? "eye.slash" : "eye")
                    .foregroundColor(.gray)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(8)
    }
}

struct LoginView: View {
    @State private var email = ""
    @State private var password = ""
    @State private var isLoggedIn = false
    @State private var showError = false

    @State var firebase = Firebasecode()

    var body: some View {
        GeometryReader { geometry in
            NavigationStack {
                ZStack {
                    Color("background")
                        .ignoresSafeArea()

                    VStack(spacing: 20) {
                        Spacer()

                        Text("Please, log in")
                            .font(.title)
                            .fontWeight(.semibold)
                            .foregroundColor(.black)

                        TextField("Enter your e-mail", text: $email)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(8)
                            .frame(width: min(geometry.size.width * 0.8, 400))

                        SecureTextField(text: $password)
                            .frame(width: min(geometry.size.width * 0.8, 400))

                        if showError, let error = firebase.loginerror {
                            Text(error)
                                .foregroundColor(.red)
                                .font(.subheadline)
                                .frame(width: min(geometry.size.width * 0.8, 400))
                        }

                        Button(action: {
                            firebase.userLogin(email: email, password: password)
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                                if firebase.loginerror == nil {
                                    isLoggedIn = true
                                } else {
                                    showError = true
                                }
                            }
                        }) {
                            Text("Log in")
                                .font(.headline)
                                .foregroundColor(.blue)
                                .frame(width: min(geometry.size.width * 0.8, 400), height: 50)
                                .background(Color.white)
                                .cornerRadius(10)
                        }

                        Spacer()

                        NavigationLink("", destination: RecommendationsView1(), isActive: $isLoggedIn)
                            .hidden()
                    }
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
        }
    }
}

#Preview {
    LoginView()
}
