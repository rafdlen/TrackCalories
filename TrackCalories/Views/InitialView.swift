//
//  InitialView.swift
//  TrackCalories
//
//  Created by Rafal on 16/05/2024.
//

import SwiftUI

struct InitialView: View {
    @State private var isLoggedIn = false

    var body: some View {
        NavigationView {
            VStack {
                Spacer()

                Text("TrackCalories")
                    .font(.system(size: 40, weight: .bold))
                    .foregroundColor(.blue)

                Text("Your personal trainer app")
                    .font(.system(size: 30, weight: .bold))
                    .foregroundColor(.blue)
                    .padding(.bottom, 20)

                Text("Join to enhance your fitness journey")
                    .font(.title3)
                    .foregroundColor(.gray)
                    .padding(.bottom, 50)

                NavigationLink(destination: LoginView(isLoggedIn: $isLoggedIn)) {
                    Text("Login")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(8)
                        .shadow(radius: 2, x: 0, y: 2)
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 20)

                NavigationLink(destination: CreateUserView()) {
                    Text("Sign Up")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .background(LinearGradient(gradient: Gradient(colors: [Color.green, Color.blue]), startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(8)
                        .shadow(radius: 2, x: 0, y: 2)
                }
                .padding(.horizontal, 24)

                Spacer()
                
                NavigationLink(destination: DashboardView(viewModel: DashboardViewModel(context: PersistenceController.shared.container.viewContext)), isActive: $isLoggedIn) {
                    EmptyView()
                }
            }
            .padding()
            .background(Color.white.edgesIgnoringSafeArea(.all))
            .navigationTitle("Welcome")
            .navigationBarHidden(true)
        }
    }
}
