//
//  GiftImagesPickerView.swift
//  GiftSwap
//
//  Created by Handerson COQ on 2/10/25.
//

import SwiftUI
import PhotosUI
import Combine

struct GiftImagesPickerView: View {
    @ObservedObject var imageManager: GiftImageManager
    var removeFetchedImage: ((String) -> Void)?

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Gift Images")
                .font(.headline)
                .frame(maxWidth: .infinity, alignment: .leading)

            HStack(alignment: .top, spacing: 10) {
                // ✅ Show fetched images from imageManager
                ForEach(imageManager.fetchedImageURLs, id: \.self) { imageUrl in
                    ZStack(alignment: .topTrailing) {
                        AsyncImage(url: URL(string: imageUrl)) { image in
                            image.resizable()
                                .scaledToFill()
                                .frame(width: 80, height: 80)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                        } placeholder: {
                            ProgressView()
                        }
                        if let removeFetchedImage = removeFetchedImage {
                            removeImageButton { removeFetchedImage(imageUrl) }
                        }
                    }
                }

                // ✅ Show manually selected images
                ForEach(imageManager.imagePreviews) { preview in
                    ZStack(alignment: .topTrailing) {
                        Image(uiImage: preview.image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 80, height: 80)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray, lineWidth: 1))
                        removeImageButton { imageManager.removeImage(preview.id) }
                    }
                }

                // ✅ Show PhotosPicker if fewer than 4 images exist
                if (imageManager.imagePreviews.count + imageManager.fetchedImageURLs.count) < 4 {
                    PhotosPicker(selection: $imageManager.selectedImages, matching: .images) {
                        VStack {
                            Image(systemName: "plus")
                                .font(.title2)
                                .padding(10)
                        }
                        .frame(width: 80, height: 80)
                        .background(Color("App_Primary").opacity(0.1))
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                }

                Spacer()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }

    private func removeImageButton(action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Image(systemName: "xmark.circle.fill")
                .font(.system(size: 18))
                .foregroundColor(.red)
                .background(Color.white.clipShape(Circle()))
                .offset(x: 5, y: -5)
        }
    }
}

