//
//  FilesViewControlle+PHPicker.swift
//  FileManager
//
//  Created by Екатерина Неделько on 10.06.22.
//

import PhotosUI

extension FilesViewController: PHPickerViewControllerDelegate {
    func uploadImage() {
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = 0
        
        let pickerViewController = PHPickerViewController(configuration: configuration)
        
        pickerViewController.delegate = self
        
        present(pickerViewController, animated: true)
    }
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        for result in results {
            let itemProvider = result.itemProvider
            guard itemProvider.canLoadObject(ofClass: UIImage.self)  else { return }

            itemProvider.loadObject(ofClass: UIImage.self) { image, error in
                guard let image = image as? UIImage  else { return }
                
                itemProvider.loadFileRepresentation(forTypeIdentifier: UTType.image.identifier) { imageURL, error in
                    guard let imageName = imageURL?.lastPathComponent else { return }
                    
                    self.manager.createImage(image, name: imageName)
                }
                 
            }
        }
            
        picker.dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        guard let fileUrl = info[UIImagePickerController.InfoKey.imageURL.rawValue] as? URL else { return }
        print(fileUrl.lastPathComponent)
    }
}
