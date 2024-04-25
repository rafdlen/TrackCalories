//
// ProfileListView.swift
//  TrackCalories
//
//  Created by Rafal on 24/04/2024.
//

import SwiftUI
import CoreData

import SwiftUI
import CoreData

struct ProfileListView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Profile.name, ascending: true)],
        animation: .default
    )
    private var profiles: FetchedResults<Profile>

    func deleteProfile(at offsets: IndexSet) {
        withAnimation {
            offsets.map { profiles[$0] }.forEach(viewContext.delete)
            do {
                try viewContext.save()
            } catch {
                // Handle the Core Data error appropriately
                let nsError = error as NSError
                fatalError("Unresolved error: \(nsError), \(nsError.userInfo)")
            }
        }
    }

    var body: some View {
        NavigationView {
            List {
                ForEach(profiles, id: \.self) { profile in
                    NavigationLink(destination: ProfileDetailView(profile: profile)) {
                        HStack {
                            if let avatarData = profile.avatar, let uiImage = UIImage(data: avatarData) {
                                Image(uiImage: uiImage)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 50, height: 50)
                                    .clipShape(Circle())
                            } else {
                                Image(systemName: "person.circle.fill")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 50, height: 50)
                                    .foregroundColor(.gray)
                            }
                            Text(profile.name ?? "Unknown")
                        }
                    }
                }
                .onDelete(perform: deleteProfile) // Enable swipe-to-delete
            }
            .navigationBarTitle("Profiles")
            .navigationBarItems(trailing: EditButton()) // Allows swipe-to-delete
        }
    }
}


//struct ProfileListView: View {
//    @Environment(\.managedObjectContext) private var viewContext
//    @FetchRequest(
//        sortDescriptors: [NSSortDescriptor(keyPath: \Profile.name, ascending: true)],
//        animation: .default)
//    private var profiles: FetchedResults<Profile>
//
//    var body: some View {
//        NavigationView {
//            List {
//                ForEach(profiles, id: \.self) { profile in
//                    NavigationLink(destination: ProfileDetailView(profile: profile)) {
//                        HStack {
//                            if let avatarData = profile.avatar, let uiImage = UIImage(data: avatarData) {
//                                Image(uiImage: uiImage)
//                                    .resizable()
//                                    .scaledToFill()
//                                    .frame(width: 50, height: 50)
//                                    .clipShape(Circle())
//                            } else {
//                                Image(systemName: "person.circle.fill")
//                                    .resizable()
//                                    .scaledToFill()
//                                    .frame(width: 50, height: 50)
//                                    .foregroundColor(.gray)
//                            }
//                            Text(profile.name ?? "Unknown")
//                        }
//                    }
//                }
//            }
//            .navigationBarTitle("Profiles")
//        }
//    }
//}

