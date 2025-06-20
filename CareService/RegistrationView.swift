//
//  RegistrationView.swift
//  CareService
//
//  Created by Kamila Ponomarova on 2025-05-22.
//



import SwiftUI

struct EcureTextField: View {
    @State private var isSecureField: Bool = true
    @Binding var text: String

    var body: some View {
        HStack {
            if isSecureField {
                SecureField("Password", text: $text)
            } else {
                TextField("Password", text: $text)
            }

            Image(systemName: isSecureField ? "eye.slash" : "eye")
                .onTapGesture {
                    isSecureField.toggle()
                }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(8)
    }
}

struct RegistrationView: View {
    @State private var name = ""
    @State private var contacts = ""
    @State private var password = ""
    @State var navigateToGeneralInfo = false

    @State var firebase = Firebasecode()

    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                ZStack {
                    Color("background").ignoresSafeArea()

                    VStack(spacing: 20) {
                        Text("Registration form")
                            .font(.title)
                            .padding(.bottom, 40)

                        TextField("", text: $name, prompt: Text("Enter your name and last name").foregroundColor(.gray))
                            .padding()
                            .background(Color.white)
                            .cornerRadius(8)
                            .frame(width: min(geometry.size.width * 0.8, 400))

                        TextField("", text: $contacts, prompt: Text("Enter e-mail").foregroundColor(.gray))
                            .padding()
                            .background(Color.white)
                            .cornerRadius(8)
                            .frame(width: min(geometry.size.width * 0.8, 400))

                        SecureTextField(text: $password)
                            .frame(width: min(geometry.size.width * 0.8, 400))

                        if firebase.loginerror != nil {
                            Text(firebase.loginerror!)
                                .foregroundColor(.red)
                                .padding(.horizontal)
                        }

                        Button(action: {
                            firebase.userRegister(email: contacts, password: password, name: name)
                            navigateToGeneralInfo = true
                        }) {
                            Text("Sign up")
                                .foregroundColor(Color.blue)
                                .frame(width: min(geometry.size.width * 0.4, 200), height: 50)
                                .background(Color.white)
                                .cornerRadius(15)
                        }
                        .padding(.top, 20)

                        Spacer()
                    }
                    .padding()
                    .navigationBarTitle("Profile", displayMode: .inline)
                }
                .navigationDestination(isPresented: $navigateToGeneralInfo) {
                    ContentView()
                }
            }
        }
    }
}

#Preview {
    RegistrationView()
}
