//
//  TrackCaloriesApp.swift
//  TrackCalories
//
//  Created by Rafal on 16/08/2022.
//

import SwiftUI

@main
struct SampleCoreDataApp: App {
    let dataController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext,
                              dataController.container.viewContext)
        }
    }
}
