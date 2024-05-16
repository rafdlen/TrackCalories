//
//  WelcomeScreenView.swift
//  TrackCalories
//
//  Created by Rafal on 18/04/2024.
//

//import SwiftUI
//
//struct WelcomeScreenView: View {
//
//    var body: some View {
//        NavigationView {
//            VStack {
//                Spacer()
//                
//                Text("TrackCalories")
//                    .font(.system(size: 40, weight: .bold))
//                    .foregroundColor(.blue)
//                
//                Text("Your personal trainer app")
//                    .font(.system(size: 30, weight: .bold))
//                    .foregroundColor(.blue)
//                    .padding(.bottom, 20)
//
//                Text("Join to enhance your fitness journey")
//                    .font(.title3)
//                    .foregroundColor(.gray)
//                    .padding(.bottom, 50)
//
//                NavigationLink(destination: LoginView()) {
//                    Text("Login")
//                        .fontWeight(.semibold)
//                        .foregroundColor(.white)
//                        .frame(minWidth: 0, maxWidth: .infinity)
//                        .padding()
//                        .background(LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .leading, endPoint: .trailing))
//                        .cornerRadius(8)
//                        .shadow(radius: 2, x: 0, y: 2)
//                }
//                .padding(.horizontal, 24)
//                .padding(.bottom, 20)
//
//                NavigationLink(destination: CreateUserView()) {
//                    Text("Sign Up")
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
//                NavigationLink(destination: CreateProfileView()) {
//                    Text("Create Profile view")
//                }
//                NavigationLink(destination: ProfileListView()) {
//                    Text("Profile list view")
//                }
//                
//                NavigationLink(destination: SurveyView()) {
//                    Text("SurveyView")
//                }
//                
//                NavigationLink(destination: DashboardView(viewModel: DashboardViewModel(context: PersistenceController.shared.container.viewContext))) {
//                    Text("Dashboard")
//                }
//                
//                Spacer()
//            }
//            .padding()
//            .background(Color.white.edgesIgnoringSafeArea(.all))
//            .navigationTitle("Welcome")
//            .navigationBarHidden(true)
//        }
//    }
//}


//import SwiftUI
//
//struct WelcomeScreenView: View {
//
//    var body: some View {
//        NavigationView {
//            VStack {
//                Spacer()
//
//                VStack {
//                    Text("TrackCalories")
//                        .font(.system(size: 40, weight: .bold))
//                        .foregroundColor(.blue)
//
//                    Text("Your personal trainer app")
//                        .font(.system(size: 30, weight: .bold))
//                        .foregroundColor(.blue)
//                        .padding(.bottom, 20)
//
//                    Text("Join to enhance your fitness journey")
//                        .font(.title3)
//                        .foregroundColor(.gray)
//                        .padding(.bottom, 50)
//                }
//
//                let columns = [
//                    GridItem(.flexible()),
//                    GridItem(.flexible())
//                ]
//
//                LazyVGrid(columns: columns, spacing: 20) {
//                    NavigationLink(destination: LoginView()) {
//                        DashboardTile(title: "Login", gradient: Gradient(colors: [Color.blue, Color.purple]))
//                    }
//                    NavigationLink(destination: CreateUserView()) {
//                        DashboardTile(title: "Sign Up", gradient: Gradient(colors: [Color.green, Color.blue]))
//                    }
//                    NavigationLink(destination: CreateProfileView()) {
//                        DashboardTile(title: "Create Profile")
//                    }
//                    NavigationLink(destination: ProfileListView()) {
//                        DashboardTile(title: "Profile List")
//                    }
//                    NavigationLink(destination: SurveyView()) {
//                        DashboardTile(title: "Survey")
//                    }
//                    NavigationLink(destination: DashboardView(viewModel: DashboardViewModel(context: PersistenceController.shared.container.viewContext))) {
//                        DashboardTile(title: "Dashboard")
//                    }
//                }
//                .padding(.horizontal, 24)
//                
//                Spacer()
//            }
//            .padding()
//            .background(Color.white.edgesIgnoringSafeArea(.all))
//            .navigationTitle("Welcome")
//            .navigationBarHidden(true)
//        }
//    }
//}
//
//struct DashboardTile: View {
//    var title: String
//    var gradient: Gradient = Gradient(colors: [Color.gray, Color.black])
//    
//    var body: some View {
//        Text(title)
//            .fontWeight(.semibold)
//            .foregroundColor(.white)
//            .frame(minWidth: 0, maxWidth: .infinity)
//            .padding()
//            .background(LinearGradient(gradient: gradient, startPoint: .leading, endPoint: .trailing))
//            .cornerRadius(8)
//            .shadow(radius: 2, x: 0, y: 2)
//    }
//}


import SwiftUI

struct WelcomeScreenView: View {
    @StateObject private var viewModel = WelcomeViewModel()

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    // Greeting message
                    Text("Hello \(viewModel.userName)")  // Display the fetched name
                        .font(.title)
                        .bold()
                        .padding()

                    // Calories Burned Chart
                    VStack(alignment: .leading) {
                        Text("Today's target")
                            .font(.headline)
                            .padding(.horizontal)
                        PieChartView(data: viewModel.caloriesBurnedToday)
                            .frame(height: 200)  // Adjust the frame height as needed
                    }
                    .padding(.horizontal)
                    
                    // Buttons grid
                    let columns = [
                        GridItem(.flexible()),
                        GridItem(.flexible())
                    ]

                    LazyVGrid(columns: columns, spacing: 20) {
//                        NavigationLink(destination: LoginView()) {
//                            DashboardTile(title: "Login", gradient: Gradient(colors: [Color.blue, Color.purple]))
//                        }
//                        NavigationLink(destination: CreateUserView()) {
//                            DashboardTile(title: "Sign Up", gradient: Gradient(colors: [Color.green, Color.blue]))
//                        }
                        
                        NavigationLink(destination: FitnessPlanCarouselView()) {
                            DashboardTile(title: "Your today's workout")
                        }
                        
                        NavigationLink(destination: CreateProfileView()) {
                            DashboardTile(title: "Create Profile")
                        }
                        NavigationLink(destination: ProfileListView()) {
                            DashboardTile(title: "Profile List")
                        }
                        NavigationLink(destination: SurveyView()) {
                            DashboardTile(title: "Survey")
                        }
                        NavigationLink(destination: DashboardView(viewModel: DashboardViewModel(context: PersistenceController.shared.container.viewContext))) {
                            DashboardTile(title: "Dashboard")
                        }
                    }
                    .padding(.horizontal, 24)
                }
                .padding()
                .background(Color.white.edgesIgnoringSafeArea(.all))
            }
            .navigationTitle("Welcome")
            .navigationBarHidden(true)
        }
        .onAppear {
            viewModel.fetchUserName()  // Fetch the user's name when the view appears
            viewModel.fetchCaloriesBurnedToday()  // Fetch the calories burned data
        }
    }
}

struct DashboardTile: View {
    var title: String
    var gradient: Gradient = Gradient(colors: [Color.gray, Color.black])
    
    var body: some View {
        Text(title)
            .fontWeight(.semibold)
            .foregroundColor(.white)
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding()
            .background(LinearGradient(gradient: gradient, startPoint: .leading, endPoint: .trailing))
            .cornerRadius(8)
            .shadow(radius: 2, x: 0, y: 2)
    }
}

class WelcomeViewModel: ObservableObject {
    @Published var userName: String = ""
    @Published var caloriesBurnedToday: [Double] = []

    func fetchUserName() {
        // Fetch the user's name from your data source
        self.userName = "John Doe"  // Example name
    }

    func fetchCaloriesBurnedToday() {
        // Fetch the calories burned data from your data source
        self.caloriesBurnedToday = [10, 20, 30, 40, 100, 300, 300]  // Example data
    }
}
