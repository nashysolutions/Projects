import SwiftUI
import PhotosUI
import UIKit

struct ImagePicker: UIViewControllerRepresentable {
    
    class Coordinator: NSObject, UINavigationControllerDelegate, PHPickerViewControllerDelegate {
        
        let parent: ImagePicker
        
        init(parent: ImagePicker) {
            self.parent = parent
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            let itemProviders = results.map(\.itemProvider)
            guard let item = itemProviders.first, item.canLoadObject(ofClass: UIImage.self) else {
                parent.didCapture(nil)
                return
            }
            item.loadObject(ofClass: UIImage.self) { (candidate, _) in
                DispatchQueue.main.async {
                    self.parent.didCapture(candidate as? UIImage)
                }
            }
        }
    }
    
    let didCapture: (UIImage?) -> Void
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> PHPickerViewController {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        return PHPickerViewController(configuration: configuration)
    }
    
    func updateUIViewController(_ controller: PHPickerViewController, context: UIViewControllerRepresentableContext<ImagePicker>) {
        controller.delegate = context.coordinator
    }
}
