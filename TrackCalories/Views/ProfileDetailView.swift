//
//  ProfileDetailView.swift
//  TrackCalories
//
//  Created by Rafal on 24/04/2024.
//

import SwiftUI

struct ProfileDetailView: View {
    @ObservedObject var profile: Profile
    @Environment(\.managedObjectContext) private var viewContext
    @State private var showImagePicker = false
    @State private var inputImage: UIImage?

    var body: some View {
        ScrollView {
            VStack {
                if let avatarData = profile.avatar, let uiImage = UIImage(data: avatarData) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.blue, lineWidth: 2))
                        .padding(.bottom, 20)
                        .onTapGesture {
                            self.showImagePicker = true
                        }
                } else {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .foregroundColor(.gray)
                        .onTapGesture {
                            self.showImagePicker = true
                        }
                }

                TextField("Name", text: Binding(get: { profile.name ?? "" }, set: { profile.name = $0 }))
                TextField("Age", value: Binding(get: { Int(profile.age) }, set: { profile.age = Int16($0) }), formatter: NumberFormatter())
                TextField("Weight (kg)", value: Binding(get: { Double(profile.weight) }, set: { profile.weight = $0 }), formatter: NumberFormatter())
                TextField("Height (cm)", value: Binding(get: { Double(profile.height) }, set: { profile.height = $0 }), formatter: NumberFormatter())
            }
            .padding()
            .navigationBarItems(trailing: Button("Save") {
                saveProfile()
            })
            .sheet(isPresented: $showImagePicker, onDismiss: loadImage) {
                ImagePicker(image: self.$inputImage)
            }
        }
    }

    private func loadImage() {
        guard let inputImage = self.inputImage else { return }
        profile.avatar = inputImage.jpegData(compressionQuality: 1.0)
        saveProfile()
    }

    private func saveProfile() {
        do {
            try viewContext.save()
        } catch {
            print("Failed to save profile: \(error.localizedDescription)")
        }
    }
}



