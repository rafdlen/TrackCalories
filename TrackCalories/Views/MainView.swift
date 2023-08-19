//
//  MainView.swift
//  TrackCalories
//
//  Created by Rafal on 17/08/2022.
//

import SwiftUI

struct MainView: View {
    @Environment(\.managedObjectContext) private var managedObjContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)], predicate: NSPredicate(format: "date >= %@ && date <= %@", Calendar.current.startOfDay(for: Date()) as CVarArg, Calendar.current.startOfDay(for: Date() + 86400) as CVarArg)) private var food: FetchedResults<Food>
    
    @Environment(\.colorScheme) var colorScheme
    
    @State private var showingAddView = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center) {
                Text("Calories today")
                    .foregroundColor(.gray)
                    .padding([.horizontal])
                
                Text("\(Int(totalCaloriesToday()))")
                    .foregroundColor(colorScheme == .dark ? .white : .black)
                    .padding([.horizontal])
                    .font(.system(size: 64, weight: .bold))

                List {
                    ForEach(food) { food in
                        NavigationLink(destination: EditFoodView(food: food)) {
                            HStack {
                                VStack(alignment: .leading, spacing: 6) {
                                    Text(food.name!)
                                        .bold()
            
                                    Text("\(Int(food.calories))") + Text(" calories").foregroundColor(.red)
                                    }
                                    Spacer()
                                    Text(calcTimeSince(date: food.date!))
                                        .foregroundColor(.gray)
                                        .italic()
                                }
                            }
                        }
                        .onDelete(perform: deleteFood)
                    }
                    .listStyle(.plain)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddView.toggle()
                    } label: {
                        Label("food", systemImage: "plus.circle.fill")
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
            }
            .sheet(isPresented: $showingAddView) {
                AddFoodView()
            }
        }
        .navigationViewStyle(.stack) // Removes sidebar on iPad
        
    }
    
// Deletes food at the current offset
private func deleteFood(offsets: IndexSet) {
    withAnimation {
        offsets.map { food[$0] }
        .forEach(managedObjContext.delete)
            
        // Saves to our database
        PersistenceController.shared.save(context: managedObjContext)
    }
}
    
// Calculates the total calories consumed today
private func totalCaloriesToday() -> Double {
    var caloriesToday : Double = 0
    for item in food {
        if Calendar.current.isDateInToday(item.date!) {
            caloriesToday += item.calories
        }
    }
    print("Calories today: \(caloriesToday)")
    return caloriesToday
    }
    
private func todayFoodOnList() -> Bool {
    var today = true
    for item in food {
        if Calendar.current.isDateInToday(item.date!) {
            return today
        }
        else {
            today = false
        }
    }
    return today
    }
    
} //

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
