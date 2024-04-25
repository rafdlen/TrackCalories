//
//  CreateProfileView.swift
//  TrackCalories
//
//  Created by Rafal on 24/04/2024.
//

import SwiftUI
import CoreData

struct CreateProfileView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var name: String = ""
    @State private var age: String = ""
    @State private var weight: String = ""
    @State private var height: String = ""
    @State private var fitnessGoals: String = ""
    @State private var avatarImage: UIImage? = UIImage(named: "defaultAvatar") // Placeholder image name
    @State private var showImagePicker: Bool = false
    @State private var showCreationError: Bool = false
    @State private var creationErrorMessage: String = ""
    @State private var inputImage: UIImage?

    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Spacer(minLength: 40)
                    
                    Text("Create Profile")
                        .font(.system(size: 40, weight: .bold))
                        .foregroundColor(Color.blue)
                        .padding(.bottom, 20)
                    
                    Text("Enter your details")
                        .font(.title3)
                        .foregroundColor(.gray)
                        .padding(.bottom, 20)
                    
                    Image(uiImage: avatarImage ?? UIImage(named: "defaultAvatar")!) // Default avatar
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.blue, lineWidth: 2))
                        .padding(.bottom, 20)
                        .onTapGesture {
                            self.showImagePicker = true
                        }
                    
                    Group {
                        TextField("Name", text: $name)
                        TextField("Age", text: $age)
                            .keyboardType(.numberPad)
                        TextField("Weight (kg)", text: $weight)
                            .keyboardType(.decimalPad)
                        TextField("Height (cm)", text: $height)
                            .keyboardType(.decimalPad)
                        TextField("Fitness Goals", text: $fitnessGoals)
                    }
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)
                    .shadow(radius: 1, x: 0, y: 2)
                    .padding(.horizontal, 24)
                    .padding(.bottom, 20)
                    
                    if showCreationError {
                        Text(creationErrorMessage)
                            .font(.title3)
                            .foregroundColor(.red)
                            .padding()
                    }
                    
                    Button(action: saveProfile) {
                        Text("Create Profile")
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding()
                            .background(LinearGradient(gradient: Gradient(colors: [Color.green, Color.blue]), startPoint: .leading, endPoint: .trailing))
                            .cornerRadius(8)
                            .shadow(radius: 2, x: 0, y: 2)
                    }
                    .padding(.horizontal, 24)
                    
                    Spacer(minLength: 40)
                }
                .padding()
                .background(Color(.systemGray6))
                .navigationBarHidden(true)
                .sheet(isPresented: $showImagePicker, onDismiss: loadImage) {
                    ImagePicker(image: self.$inputImage)
                }
            }
        }
    }

    private func loadImage() {
        guard let inputImage = inputImage else { return }
        avatarImage = inputImage
    }

    private func saveProfile() {
        let newProfile = Profile(context: viewContext)
        newProfile.name = name
        newProfile.age = Int16(age) ?? 0
        newProfile.weight = Double(weight) ?? 0.0
        newProfile.height = Double(height) ?? 0.0
        newProfile.avatar = avatarImage?.jpegData(compressionQuality: 1.0)
        
        do {
            try viewContext.save()
            creationErrorMessage = ""
            showCreationError = false
        } catch {
            creationErrorMessage = "Failed to create profile: \(error.localizedDescription)"
            showCreationError = true
        }
    }
}

struct ContentView: View {
    var body: some View {
        CreateProfileView()
            .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }
            picker.dismiss(animated: true)
        }
    }
}


