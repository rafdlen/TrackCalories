//
//  CoreDataTests.swift
//  TrackCaloriesTests
//
//  Created by Rafal on 02/09/2023.
//

import XCTest
import CoreData
@testable import TrackCalories

class DataModelTests: XCTestCase {
    
    var testableDataContainer: PersistenceController!
    var context: NSManagedObjectContext!
    
    override func setUp() {
        super.setUp()
        testableDataContainer = PersistenceController(inMemory: true)
        context = testableDataContainer.container.viewContext
    }
    
    override func tearDown() {
        super.tearDown()
        testableDataContainer = nil
        context = nil
        
    }
    
    func testCanAddMealToTheDataModel() throws {
        PersistenceController.shared.addFood(name: "Apple", calories: 60, context: context)
        
        try context.save()
        
        let fetchRequest: NSFetchRequest<Food> = Food.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", "Apple")
        
        let fetchedResults = try context.fetch(fetchRequest)
        
        if let firstResult = fetchedResults.first {
            XCTAssertEqual(firstResult.name, "Apple")
            XCTAssertEqual(firstResult.calories, 60)
        }
    }
    
    func testCanEditMealInTheDataModel() throws {
        PersistenceController.shared.addFood(name: "Orange", calories: 50, context: context)
        
        try context.save()
        
        let fetchRequest: NSFetchRequest<Food> = Food.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", "Orange")
        

        let foodToEdit = try context.fetch(fetchRequest)[0]
        
        PersistenceController.shared.editFood(food: foodToEdit, name: "Plum", calories: 160, context: context)
        
        let editedFetchRequest: NSFetchRequest<Food> = Food.fetchRequest()
        editedFetchRequest.predicate = NSPredicate(format: "name == %@", "Plum")
        
        let editedFood = try context.fetch(editedFetchRequest)
        
        if let firstResult = editedFood.first {
            XCTAssertEqual(firstResult.name, "Plum")
            XCTAssertEqual(firstResult.calories, 160)
        }
    }
    
    func testCanRemoveMealFromTheDataModel() throws {
        PersistenceController.shared.addFood(name: "Biscuits", calories: 600, context: context)
        
        try context.save()
        
        let fetchRequest: NSFetchRequest<Food> = Food.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "name == %@", "Biscuits")
        
        let foodToRemove = try context.fetch(fetchRequest)[0]
        
        context.delete(foodToRemove)
        try context.save()
   
        let remainingFoods = try context.fetch(fetchRequest)

        XCTAssertTrue(remainingFoods.isEmpty)
    }
}



