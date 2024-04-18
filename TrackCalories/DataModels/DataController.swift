//
//  DataController.swift
//  TrackCalories
//
//  Created by Rafal on 16/08/2022.
//

//import Foundation
//import CoreData
//
//class PersistenceController: ObservableObject {
//    static let shared = PersistenceController()
//
//    static var preview: PersistenceController = {
//        let result = PersistenceController(inMemory: true)
//        let viewContext = result.container.viewContext
//        do {
//            try viewContext.save()
//        } catch {
//            let nsError = error as NSError
//            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//        }
//        return result
//    }()
//
//    let container: NSPersistentContainer
//    
//    init(inMemory: Bool = false) {
//        container = NSPersistentContainer(name: "FoodModel")
//        if inMemory {
//            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
//        }
//        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
//            if let error = error as NSError? {
//                fatalError("Unresolved error \(error), \(error.userInfo)")
//            }
//        })
//        container.viewContext.automaticallyMergesChangesFromParent = true
//    }
//    
//    func save(context: NSManagedObjectContext) {
//        do {
//            try context.save()
//            print("Data has been saved successfully.")
//        } catch {
//            // Handle errors in our database
//            let nsError = error as NSError
//            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
//        }
//    }
//    
//    func addFood(name: String, calories: Double, context: NSManagedObjectContext) {
//        let food = Food(context: context)
//        food.id = UUID()
//        food.date = Date()
//        food.name = name
//        food.calories = calories
//        
//        save(context: context)
//    }
//    
//    func editFood(food: Food, name: String, calories: Double, context: NSManagedObjectContext) {
//        food.name = name
//        food.calories = calories
//        
//        save(context: context)
//    }
//}











