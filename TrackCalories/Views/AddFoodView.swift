//
//  AddFoodView.swift
//  TrackCalories
//
//  Created by Rafal on 16/08/2022.
//

//import Foundation
//import SwiftUI
//
//struct AddFoodView: View {
//    @Environment(\.managedObjectContext) var managedObjContext
//    @Environment(\.dismiss) var dismiss
//    
//    @State private var name = ""
//    @State private var calories: Double = 0
//
//    
//    var body: some View {
//            Form {
//                Section() {
//                    TextField("What have you eaten?", text: $name)
//                    
//                    VStack {
//                        Text("Calories: \(Int(calories))")
//                        Slider(value: $calories, in: 0...2000, step: 10)
//
//                    }
//                    .padding()
//                    
//                    HStack {
//                        Spacer()
//                        Button("Add meal") {
//                            PersistenceController.shared.addFood(
//                                name: name,
//                                calories: calories,
//                                context: managedObjContext)
//                            dismiss()
//                        }
//                        Spacer()
//                    }
//                }
//        }
//    }
//}
//
//struct AddFoodView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddFoodView()
//    }
//}
