import PhotosUI
import SwiftUI
import UIKit

struct PhotoPickerButton: View {
    @State private var item: PhotosPickerItem?
    let title: String
    let onImagePicked: (UIImage, Data) -> Void

    var body: some View {
        PhotosPicker(selection: $item, matching: .images) {
            Text(title)
                .font(AppFont.body(16))
                .foregroundStyle(AppTheme.ink)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 14)
                .background(Color.white.opacity(0.5))
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                .overlay(
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .stroke(AppTheme.softBorder, lineWidth: 1)
                )
        }
        .buttonStyle(.plain)
        .task(id: item) {
            guard let item else { return }
            if let data = try? await item.loadTransferable(type: Data.self),
               let image = UIImage(data: data) {
                onImagePicked(image, data)
            }
        }
    }
}

struct CameraCaptureSheet: UIViewControllerRepresentable {
    let onImagePicked: (UIImage, Data) -> Void

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .camera
        picker.cameraCaptureMode = .photo
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(onImagePicked: onImagePicked)
    }

    final class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let onImagePicked: (UIImage, Data) -> Void

        init(onImagePicked: @escaping (UIImage, Data) -> Void) {
            self.onImagePicked = onImagePicked
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true)
        }

        func imagePickerController(
            _ picker: UIImagePickerController,
            didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]
        ) {
            guard let image = info[.originalImage] as? UIImage,
                  let data = image.jpegData(compressionQuality: 0.92) else {
                picker.dismiss(animated: true)
                return
            }

            onImagePicked(image, data)
            picker.dismiss(animated: true)
        }
    }
}
