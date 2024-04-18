//
//  History.swift
//  TrackCalories
//
//  Created by Rafal on 17/08/2022.
//

//import SwiftUI
//import CoreData
//
//struct History: View {
//    @Environment(\.managedObjectContext) var managedObjContext
//    @SectionedFetchRequest<String, Food>(
//        sectionIdentifier: \.sectionDate,
//        sortDescriptors: [SortDescriptor(\.date, order: .reverse)]
//    )
//    private var sections: SectionedFetchResults<String, Food>
//    
//    var body: some View {
//        NavigationView {
//            VStack(alignment: .center) {
//                Text("History")
//                    .font(.title).italic()
//                    .foregroundColor(.gray)
//                List {
//                    ForEach(sections) {
//                        section in Text("\(section.id)").bold()
//                        Text("Total calories consumed: ") + Text(String(section.map{$0.calories}.reduce(0, +))) + Text(" calories").foregroundColor(.green)
//                        ForEach(section) {
//                                food in
//                                    HStack {
//                                        VStack(alignment: .leading, spacing: 6) {
//                                            Text(food.name!) +
//                                            Text(": \(Int(food.calories))") + Text(" calories").foregroundColor(.green)
//                                            Spacer()
//                                    }
//                                }
//                                    .swipeActions(content: {
//                                        Button(role: .destructive, action: {
//                                            deleteFood(food: food)
//                                        }, label: {
//                                            Image(systemName: "trash")
//                                        })
//                                    })
//                        }
//                    }
//                    
//                }
//                    }
//                    .listStyle(.plain)
//                }
//        }
//    public func deleteFood(food: Food){
//        managedObjContext.delete(food)
//        do{
//            try managedObjContext.save()
//        } catch{
//            print(error)
//        }
//    }
//}
//
//struct History_Previews: PreviewProvider {
//    static var previews: some View {
//        History()
//    }
//}
//
//    
//extension Food{
//    @objc
//    var sectionDate: String{
//                    
//        if self.date != nil{
//            let dateFormatter: DateFormatter = DateFormatter()
//            dateFormatter.dateFormat = "dd.MM.yyyy"
//            return dateFormatter.string(from: self.date!)
//             
//        } else {
//            return ""
//        }
//    }
//}


