import SwiftUI

struct FitnessPlanCarouselView: View {
    private let exercises = [
        ("Push-ups", "A basic exercise that works the chest, shoulders, and triceps."),
        ("Pull-ups", "An exercise to strengthen the back and biceps."),
        ("Squats", "A lower body exercise that targets the quads, hamstrings, and glutes."),
        ("Lunges", "A single-leg bodyweight exercise that works your hips, glutes, and legs."),
        ("Plank", "An isometric core exercise that builds stability and strength."),
        ("Burpees", "A full body exercise that boosts cardiovascular fitness."),
        ("Bicep Curls", "An exercise to build strength in the biceps."),
        ("Tricep Dips", "An exercise that targets the triceps, chest, and shoulders."),
        ("Deadlifts", "A compound movement that works the entire posterior chain."),
        ("Bench Press", "A classic upper body exercise that works the chest, shoulders, and triceps."),
        ("Mountain Climbers", "A cardio exercise that also strengthens the core."),
        ("Russian Twists", "An exercise that targets the oblique muscles."),
        ("Leg Raises", "An exercise to strengthen the lower abs."),
        ("Jumping Jacks", "A cardio move that also helps with coordination."),
        ("High Knees", "A high-intensity cardio exercise that engages the core.")
    ]
    
    var body: some View {
        NavigationView {
            VStack {

                // Fitness Plan Description
                Text("We designed carefully desogned this plan for you to improve your fitness, strength, and endurance.")
                    .font(.title2)
                    .padding(.bottom, 20)
                    .padding(.horizontal)

                // Exercises Carousel
                TabView {
                    ForEach(exercises, id: \.0) { exercise in
                        ExerciseCardView(exercise: exercise.0, description: exercise.1)
                            .padding(.horizontal, 20)
                    }
                }
                .tabViewStyle(PageTabViewStyle())
                .frame(height: 300)  // Adjust height as needed
                .padding(.bottom, 20)

                Spacer()
            }
            .navigationTitle("Fitness Plan")
        }
    }
}

struct ExerciseCardView: View {
    var exercise: String
    var description: String

    var body: some View {
        VStack {
            Text(exercise)
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, 20)
            Text(description)
                .font(.body)
                .padding()
            Spacer()
        }
        .frame(width: UIScreen.main.bounds.width - 40, height: 250)
        .background(LinearGradient(gradient: Gradient(colors: [Color.orange, Color.red]), startPoint: .topLeading, endPoint: .bottomTrailing))
        .cornerRadius(15)
        .shadow(radius: 5)
    }
}



