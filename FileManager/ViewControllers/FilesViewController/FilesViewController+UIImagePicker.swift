//
//  FilesViewController+UIImagePicker.swift
//  FileManager
//
//  Created by Екатерина Неделько on 10.06.22.
//

import UIKit

extension FilesViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func uploadCameraPhoto() {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        
        imagePicker.allowsEditing = true
        
        imagePicker.delegate = self
        
        present(imagePicker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage,
              let imageName = (info[.imageURL] as? URL)?.lastPathComponent else {
            return
        }
        
        manager.createImage(image, name: imageName)
        
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        print("canceled")
        
        picker.dismiss(animated: true)
    }
}
