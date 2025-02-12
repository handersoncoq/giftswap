//
//  GiftImageManager.swift
//  GiftSwap
//
//  Created by Handerson COQ on 2/10/25.
//

import SwiftUI
import PhotosUI
import Combine

// Wrapper struct to hold UIImage with a unique ID
struct GiftImage: Identifiable, Equatable {
    let id = UUID()
    let image: UIImage
}

// Reusable image manager for handling image selection, removal, and saving
class GiftImageManager: ObservableObject {
    @Published var selectedImages: [PhotosPickerItem] = []
    @Published var imagePreviews: [GiftImage] = []
    @Published var fetchedImageURLs: [String] = []

    private var cancellables = Set<AnyCancellable>()

    init() {
        $selectedImages
            .sink { newSelections in
                self.loadImages(from: newSelections)
            }
            .store(in: &cancellables)
    }
    
    func loadImages(from selections: [PhotosPickerItem]) {
        imagePreviews = []
        let dispatchGroup = DispatchGroup()

        for selection in selections.prefix(4) {
            dispatchGroup.enter()
            selection.loadTransferable(type: Data.self) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let data):
                        if let data = data, let image = UIImage(data: data) {
                            self.imagePreviews.append(GiftImage(image: image))
                        }
                    case .failure(let error):
                        print("Image loading failed: \(error.localizedDescription)")
                    }
                    dispatchGroup.leave()
                }
            }
        }

        dispatchGroup.notify(queue: .main) {
            print("Finished loading images")
        }
    }




    
    func removeImage(_ id: UUID) {
        DispatchQueue.main.async {
            withAnimation(.easeInOut(duration: 0.2)) {
                self.imagePreviews.removeAll { $0.id == id }
            }
        }
    }

    func saveImagesTemporarily() -> [String] {
        var imageURLs: [String] = []

        for (index, preview) in imagePreviews.enumerated() {
            if let imageData = preview.image.jpegData(compressionQuality: 0.8) {
                let filename = "gift_image_\(index).jpg"
                let tempURL = FileManager.default.temporaryDirectory.appendingPathComponent(filename)

                do {
                    try imageData.write(to: tempURL)
                    imageURLs.append(tempURL.absoluteString)
                } catch {
                    print("Error saving image: \(error.localizedDescription)")
                }
            }
        }

        return imageURLs
    }
}

