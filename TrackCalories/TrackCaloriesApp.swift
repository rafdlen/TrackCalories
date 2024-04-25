//
//  TrackCaloriesApp.swift
//  TrackCalories
//
//  Created by Rafal on 16/08/2022.
//

import SwiftUI

@main
struct TrackCalories: App {
    let dataController = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            WelcomeScreenView()
                .environment(\.managedObjectContext, dataController.container.viewContext)

        }
    }
}
