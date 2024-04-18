//
//  CreateUserView.swift
//  TrackCalories
//
//  Created by Rafal on 18/04/2024.
//


import SwiftUI
import CoreData
import KeychainSwift
import CryptoKit

struct CreateUserView: View {
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    @Environment(\.managedObjectContext) private var managedObjectContext

    var body: some View {
        NavigationView {
            VStack {
                Spacer(minLength: 40)

                Text("Join TrackCalories")
                    .font(.system(size: 40, weight: .bold))
                    .foregroundColor(Color.green)
                    .padding(.bottom, 10)

                Text("Sign up to start your journey")
                    .font(.title3)
                    .foregroundColor(.gray)
                    .padding(.bottom, 20)

                TextField("Username", text: $username)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)
                    .shadow(radius: 1, x: 0, y: 2)
                    .padding(.horizontal, 24)
                    .padding(.bottom, 20)

                TextField("Email", text: $email)
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

                Button(action: createUser) {
                    Text("Create Account")
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
    }
    
    private func createUser() {
        let keychain = KeychainSwift()

        // Generate a salt and hash the password using SHA-256
        let salt = UUID().uuidString
        let saltedPassword = password + salt
        let hashedPassword = self.sha256(saltedPassword)
        
        // Store the hashed password and salt in Keychain
        keychain.set(hashedPassword, forKey: "hashedPassword:\(username)")
        keychain.set(salt, forKey: "salt:\(username)")

        // Create a new User instance for Core Data
        let newUser = User(context: managedObjectContext)
        newUser.username = username
        newUser.email = email
        
        // Save to Core Data
        do {
            try managedObjectContext.save()
            print("User saved successfully")
        } catch {
            print("Failed to save user: \(error)")
        }
    }
    
    private func sha256(_ input: String) -> String {
        let inputPassword = Data(input.utf8)
        let hashedPassword = SHA256.hash(data: inputPassword)
        return hashedPassword.compactMap { String(format: "%02x", $0) }.joined()
    }
}
