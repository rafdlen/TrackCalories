//
//  LoginView.swift
//  TrackCalories
//
//  Created by Rafal on 18/04/2024.
//

//import SwiftUI
//import KeychainSwift
//import CryptoKit
//
//struct LoginView: View {
//    @State private var username: String = ""
//    @State private var password: String = ""
//    @State private var displayLoginError: Bool = false
//    @State private var loginErrorMessage: String = ""
//    
//    var body: some View {
//        NavigationView {
//            VStack {
//                Spacer(minLength: 40)
//                
//                Text("TrackCalories")
//                    .font(.system(size: 40, weight: .bold))
//                    .foregroundColor(Color.blue)
//                    .padding(.bottom, 20)
//                
//                Text("Log in to continue")
//                    .font(.title3)
//                    .foregroundColor(.gray)
//                    .padding(.bottom, 30)
//                
//                TextField("Username", text: $username)
//                    .padding()
//                    .background(Color.white)
//                    .cornerRadius(8)
//                    .shadow(radius: 1, x: 0, y: 2)
//                    .padding(.horizontal, 24)
//                    .padding(.bottom, 20)
//                
//                SecureField("Password", text: $password)
//                    .padding()
//                    .background(Color.white)
//                    .cornerRadius(8)
//                    .shadow(radius: 1, x: 0, y: 2)
//                    .padding(.horizontal, 24)
//                    .padding(.bottom, 20)
//                
//                if displayLoginError {
//                    Text(loginErrorMessage)
//                        .font(.title3)
//                        .foregroundColor(.red)
//                        .padding()
//                }
//                
//                Button(action: loginAction) {
//                    Text("Login")
//                        .fontWeight(.semibold)
//                        .foregroundColor(.white)
//                        .frame(minWidth: 0, maxWidth: .infinity)
//                        .padding()
//                        .background(LinearGradient(gradient: Gradient(colors: [Color.green, Color.blue]), startPoint: .leading, endPoint: .trailing))
//                        .cornerRadius(8)
//                        .shadow(radius: 2, x: 0, y: 2)
//                }
//                .padding(.horizontal, 24)
//                
//                Spacer(minLength: 40)
//            }
//            .padding()
//            .background(Color(.systemGray6))
//            .navigationBarHidden(true)
//        }
//    }
//    
//    private func loginAction() {
//        let keychain = KeychainSwift()
//        let salt = keychain.get("salt:\(username)")
//        let savedHashedPassword = keychain.get("hashedPassword:\(username)")
//        
//        if let salt = salt, let storedHashedPassword = savedHashedPassword, let hashedPassword = hashPassword(password, withSalt: salt), hashedPassword == storedHashedPassword {
//            DispatchQueue.main.async {
//                self.displayLoginError = false
//            }
//        } else {
//            DispatchQueue.main.async {
//                self.loginErrorMessage = "Invalid username or password"
//                self.displayLoginError = true
//            }
//        }
//    }
//    
//    private func hashPassword(_ password: String, withSalt salt: String) -> String? {
//        let saltedPassword = password + salt
//        let inputPassword = Data(saltedPassword.utf8)
//        let hashedPassword = SHA256.hash(data: inputPassword)
//        return hashedPassword.compactMap { String(format: "%02x", $0) }.joined()
//    }
//}

import SwiftUI
import KeychainSwift
import CryptoKit

struct LoginView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var displayLoginError: Bool = false
    @State private var loginErrorMessage: String = ""
    @Binding var isLoggedIn: Bool

    var body: some View {
        VStack {
            Spacer(minLength: 40)
            
            Text("TrackCalories")
                .font(.system(size: 40, weight: .bold))
                .foregroundColor(Color.blue)
                .padding(.bottom, 20)
            
            Text("Log in to continue")
                .font(.title3)
                .foregroundColor(.gray)
                .padding(.bottom, 30)
            
            TextField("Username", text: $username)
                .padding()
                .background(Color.white)
                .cornerRadius(8)
                .shadow(radius: 1, x: 0, y: 2)
                .padding(.horizontal, 24)
                .padding(.bottom, 20)
            
            SecureField("Password", text: $password)
                .padding()
                .background(Color.white)
                .cornerRadius(8)
                .shadow(radius: 1, x: 0, y: 2)
                .padding(.horizontal, 24)
                .padding(.bottom, 20)
            
            if displayLoginError {
                Text(loginErrorMessage)
                    .font(.title3)
                    .foregroundColor(.red)
                    .padding()
            }
            
            Button(action: loginAction) {
                Text("Login")
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding()
                    .background(LinearGradient(gradient: Gradient(colors: [Color.green, Color.blue]), startPoint: .leading, endPoint: .trailing))
                    .cornerRadius(8)
                    .shadow(radius: 2, x: 0, y: 2)
            }
            .padding(.horizontal, 24)
            
            Spacer(minLength: 40)
        }
        .padding()
        .background(Color(.systemGray6))
        .navigationBarHidden(true)
    }
    
    private func loginAction() {
        let keychain = KeychainSwift()
        let salt = keychain.get("salt:\(username)")
        let savedHashedPassword = keychain.get("hashedPassword:\(username)")
        
        if let salt = salt, let storedHashedPassword = savedHashedPassword, let hashedPassword = hashPassword(password, withSalt: salt), hashedPassword == storedHashedPassword {
            DispatchQueue.main.async {
                self.displayLoginError = false
                self.isLoggedIn = true  // Navigate to DashboardView
            }
        } else {
            DispatchQueue.main.async {
                self.loginErrorMessage = "Invalid username or password"
                self.displayLoginError = true
            }
        }
    }
    
    private func hashPassword(_ password: String, withSalt salt: String) -> String? {
        let saltedPassword = password + salt
        let inputPassword = Data(saltedPassword.utf8)
        let hashedPassword = SHA256.hash(data: inputPassword)
        return hashedPassword.compactMap { String(format: "%02x", $0) }.joined()
    }
}
