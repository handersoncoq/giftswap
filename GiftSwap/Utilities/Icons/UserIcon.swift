//
//  UserIcon.swift
//  GiftSwap
//
//  Created by Handerson COQ on 1/28/25.
//

import SwiftUI
import PhotosUI

struct UserIcon: View {
    @State private var selectedImage: UIImage? = nil
    @State private var isShowingImagePicker = false
    
    var body: some View {
        ZStack {
            NavigationLink(destination: UserProfileView()) {
                Group {
                    if let selectedImage = selectedImage {
                        Image(uiImage: selectedImage)
                            .resizable()
                            .scaledToFill()
                    } else {
                        Image("UserProfile")
                            .symbolRenderingMode(.monochrome)
                            .font(.system(size: 55, weight: .ultraLight))
                            .foregroundColor(.gray.opacity(0.3))
                    }
                }
                .frame(width: 90, height: 90)
                .background(Color.white)
                .clipShape(Circle())
                .shadow(color: Color.black.opacity(0.3), radius: 2, x: 0, y: 4)
            }
            
            // Plus Button (Bottom Right Corner)
            Button(action: {
                isShowingImagePicker.toggle()
            }) {
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .frame(width: 25, height: 25)
                    .foregroundColor(Color("App_Primary"))
                    .background(Color.white)
                    .clipShape(Circle())
                    .shadow(radius: 2)
            }
            .offset(x: 30, y: 30)
            .sheet(isPresented: $isShowingImagePicker) {
                ImagePicker(selectedImage: $selectedImage)
            }
        }
    }
}

// Image Picker Helper
struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .photoLibrary
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        var parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.selectedImage = image
            }
            picker.dismiss(animated: true)
        }
    }
}

// Preview
struct UserIcon_Previews: PreviewProvider {
    static var previews: some View {
        UserIcon()
            .previewLayout(.sizeThatFits)
    }
}


