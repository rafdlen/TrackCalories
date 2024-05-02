//
//  SurveyView.swift
//  TrackCalories
//
//  Created by Rafal on 02/05/2024.
//
import SwiftUI
import CoreData

struct SurveyView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var fitnessGoals: String = ""
    @State private var experienceLevel: String = ""
    @State private var availableEquipment: String = ""
    @State private var workoutPreference: String = ""
    @State private var timeAvailability: String = ""
    
    let goals = ["Lose Weight", "Gain Muscle", "Improve Endurance", "Increase Flexibility", "General Fitness"]

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Fitness Goals")) {
                    Picker("Select your fitness goals", selection: $fitnessGoals) {
                        Text("Lose Weight").tag("Lose Weight")
                        Text("Gain Muscle").tag("Gain Muscle")
                        Text("Improve Endurance").tag("Improve Endurance")
                        Text("Increase Flexibility").tag("Increase Flexibility")
                        Text("General Fitness").tag("General Fitness")
                    }
                    .pickerStyle(WheelPickerStyle())
                    .frame(maxHeight: 100)
                }
                    
                Section(header: Text("Experience Level")) {
                    Picker("Select your experience level", selection: $experienceLevel) {
                        Text("Beginner").tag("Beginner")
                        Text("Intermediate").tag("Intermediate")
                        Text("Advanced").tag("Advanced")
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }

                Section(header: Text("Available Equipment")) {
                    TextField("List available equipment (e.g., dumbbells, treadmill)", text: $availableEquipment)
                }
                Section(header: Text("Workout Preference")) {
                    Picker("Preferred type of workout", selection: $workoutPreference) {
                        Text("Strength").tag("Strength")
                        Text("Cardio").tag("Cardio")
                        Text("Mixed").tag("Mixed")
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                Section(header: Text("Time Availability")) {
                    TextField("Available time per session (in minutes)", text: $timeAvailability)
                        .keyboardType(.numberPad)
                }
            }
            .navigationBarTitle("Fitness Plan Survey")
            .navigationBarItems(trailing: Button("Submit") {
                submitSurvey()
            })
        }
    }

    private func submitSurvey() {
        let newFitnessPlan = FitnessPlan(context: viewContext)
        newFitnessPlan.goals = fitnessGoals
        newFitnessPlan.experienceLevel = experienceLevel
        newFitnessPlan.equipment = availableEquipment
        newFitnessPlan.workoutPreference = workoutPreference
        newFitnessPlan.timeAvailability = Int16(timeAvailability) ?? 0

        do {
            try viewContext.save()
        } catch {
            print("Failed to save fitness plan: \(error.localizedDescription)")
        }
    }
}

extension FitnessPlan {
}

