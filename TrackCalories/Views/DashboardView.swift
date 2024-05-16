//
//  DashboardView.swift
//  TrackCalories
//
//  Created by Rafal on 08/05/2024.
//

import SwiftUI
import CoreData


struct PieSliceView: Shape {
    var startAngle: Angle
    var endAngle: Angle
    
    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = min(rect.width, rect.height) / 2
        var path = Path()
        
        path.move(to: center)
        path.addArc(center: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: false)
        path.closeSubpath()
        
        return path
    }
}

struct PieChartView: View {
    var data: [Double]  // The calories burned values
    let goal: Double = 2000  // Daily calorie goal
    
    var angles: [Angle] {
        var total = 0.0
        var angles = [Angle]()
        data.forEach { value in
            total += value
            let angle = total / goal * 360
            angles.append(.degrees(angle))
        }
        return angles
    }
    
    var body: some View {
        ZStack {
            ForEach(data.indices, id: \.self) { index in
                PieSliceView(startAngle: index == 0 ? .degrees(0) : angles[index - 1],
                             endAngle: angles[index])
                .fill(index % 2 == 0 ? Color.blue : Color.green)
            }
        }
        .frame(width: 200, height: 200)
        .aspectRatio(1, contentMode: .fit)
    }
}


struct DashboardView: View {
    // Dummy Data Arrays
    let caloriesBurned = [200, 500, 300, 700, 100]
    let stepsTaken = [3000, 4500, 2000, 6000, 2500]
    let workoutDuration = [30, 45, 20, 60, 25] // in minutes
    let caloriesBurnedToday: [Double] = [1200, 300]
    
    @ObservedObject var viewModel: DashboardViewModel
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Hello \(viewModel.userName)")  // Display the fetched name
                                            .font(.title)
                                            .bold()
                                            .padding()
                    

                    
                    // Calories Burned Chart
                    VStack(alignment: .leading) {
                        Text("Today's target")
                            .font(.headline)
                            .padding(.horizontal)
                        PieChartView(data: caloriesBurnedToday)
                    }
                    
                    
                   // PieChartView(data: caloriesBurnedToday)
                       // .padding()
                    
                    Text("Weekly Summary")
                        .font(.title)
                        .bold()
                        .padding()
                    
                    // Calories Burned Chart
                    VStack(alignment: .leading) {
                        Text("Calories Burned This Week")
                            .font(.headline)
                            .padding(.horizontal)
                        ChartView(data: caloriesBurned, label: "Calories", color: .red)
                    }
                    
                    // Steps Taken Chart
                    VStack(alignment: .leading) {
                        Text("Steps Taken This Week")
                            .font(.headline)
                            .padding(.horizontal)
                        ChartView(data: stepsTaken, label: "Steps", color: .green)
                    }
                    
                    // Workout Duration Chart
                    VStack(alignment: .leading) {
                        Text("Workout Duration This Week")
                            .font(.headline)
                            .padding(.horizontal)
                        ChartView(data: workoutDuration, label: "Minutes", color: .blue)
                    }
                }
            }
            .navigationTitle("Dashboard")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct ChartView: View {
    var data: [Int]
    var label: String
    var color: Color
    
    var maxValue: Int {
        guard let max = data.max() else { return 1 }
        return max > 0 ? max : 1
    }
    
    var body: some View {
        HStack(alignment: .bottom) {
            ForEach(data.indices, id: \.self) { index in
                VStack {
                    Spacer()
                    Rectangle()
                        .fill(color)
                        .frame(width: 20, height: CGFloat(data[index]) / CGFloat(maxValue) * 200.0)
                    Text("\(data[index])")
                        .font(.caption)
                }
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color(.secondarySystemBackground))
        .cornerRadius(8)
        .padding(.horizontal)
    }
}


class DashboardViewModel: ObservableObject {
    @Published var userName: String = ""
    private var context: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.context = context
        fetchUserName()
    }

    private func fetchUserName() {
        let request = NSFetchRequest<Profile>(entityName: "Profile")
        do {
            let results = try context.fetch(request)
            self.userName = results.first?.name ?? "Unknown"
        } catch {
            print("Error fetching name")
        }
    }
}

struct DashboardView_Previews: PreviewProvider {
    static var previews: some View {
        DashboardView(viewModel: DashboardViewModel(context: PersistenceController.shared.container.viewContext))    }
}
