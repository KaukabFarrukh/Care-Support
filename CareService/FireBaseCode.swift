//
//  FireBaseCode.swift
//  CareSupport 
//
//  Created by Kaukab Farrukh on 2025-05-22.
//


import Foundation
import FirebaseAuth

@Observable class Firebasecode {
    
    var loginerror: String?
    
    func userRegister(email: String, password: String, name: String) {
        loginerror = nil   // ✅ clear previous error
        Task {
            do {
                _ = try await Auth.auth().createUser(withEmail: email, password: password)
                await MainActor.run {
                    self.loginerror = nil   // ✅ success: no error
                }
            } catch {
                let message = error.localizedDescription
                print("FEL REG: \(message)")
                await MainActor.run {
                    self.loginerror = message   // ✅ show real error
                }
            }
        }
    }
    
    func userLogin(email: String, password: String) {
        loginerror = nil   // ✅ clear previous error before new attempt
        Task {
            do {
                _ = try await Auth.auth().signIn(withEmail: email, password: password)
                await MainActor.run {
                    self.loginerror = nil   // ✅ success
                }
            } catch {
                let message = error.localizedDescription
                print("FEL LOGIN: \(message)")
                await MainActor.run {
                    self.loginerror = message   // ✅ show real error
                }
            }
        }
    }
    
    func userLogout() {
        do {
            try Auth.auth().signOut()
        } catch {
            print("Logout error: \(error.localizedDescription)")
        }
    }
}
