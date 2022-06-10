//
//  ViewController.swift
//  FileManager
//
//  Created by Екатерина Неделько on 31.05.22.
//

import UIKit
import PhotosUI

class FilesViewController: UIViewController {
    
    var filesTableView: UITableView!
    var filesCollectionView: UICollectionView!
    
    var manager = FilesManagerService()
    
    var mainMenuItems: [UIMenuElement] {
        return [
            UIAction(title: "Select", image: UIImage(systemName: "checkmark.circle"), attributes: .disabled, handler: { (_) in
                    }),
            UIAction(title: "Add new folder",
                     image: UIImage(systemName: "folder.badge.plus"),
                     handler: { _ in
                self.handleNewFileButtonTap()
            }),
            UIAction(title: "Add new photo",
                     image: UIImage(systemName: "photo"),
                     handler: { _ in
                         self.handleNewFileButtonTap(type: .photo)
            }),
            UIAction(title: "Upload image",
                     image: UIImage(systemName: "rectangle.stack.badge.plus"),
                     handler: { _ in
                self.handleNewFileButtonTap(type: .image)
            }),
            UIAction(title: "Delete", image: UIImage(systemName: "trash"), attributes: .destructive, handler: { (_) in
            }),
            UIMenu(title: "", options: .displayInline, children: switchInterfaceItems)
        ]
    }
    
    var switchInterfaceItems: [UIAction] {
        return [
            UIAction(title: ViewType.list.rawValue,
                     image: UIImage(systemName: "list.bullet"),
                     handler: { _ in
                         UserDefaults.standard.set(ViewType.list.rawValue, forKey: ViewType.settingName)
                         self.manager.viewType = .list
            }),
            UIAction(title: ViewType.icons.rawValue,
                     image: UIImage(systemName: "rectangle.grid.2x2"),
                     handler: { _ in
                         UserDefaults.standard.set(ViewType.icons.rawValue, forKey: ViewType.settingName)
                         self.manager.viewType = .icons
            })
        ]
    }

    var mainMenu: UIMenu {
        return UIMenu(title: "Menu", children: mainMenuItems)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        manager.delegate = self
        
        setUpNavigationBar()
        setUpTableView()
        setUpCollectionView()
        
        manager.updateFilesData()
        
        let viewTypeSetting = UserDefaults.standard.string(forKey: ViewType.settingName)
        manager.viewType = viewTypeSetting == ViewType.icons.rawValue ? .icons : .list
    }
    
    private func setUpNavigationBar() {
        let rightBarButtonItem = UIBarButtonItem(title: nil, image: UIImage(systemName: "ellipsis.circle"), primaryAction: nil, menu: mainMenu)
        
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    private func showAlert() {
        let alertController = UIAlertController(title: "New folder",
                                                message: "Enter a name for this folder",
                                                preferredStyle: .alert)
        
        let saveAction = UIAlertAction(title: "Save",
                                       style: .default) { _ in
            guard let textFields = alertController.textFields else {
                return
            }
            
            if let nameTextField = textFields.first {
                self.manager.addDirectory(name: nameTextField.text ?? "")
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .cancel)
        
        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)
        
        alertController.addTextField { textField in
            textField.placeholder = "Name"
        }
        
        present(alertController, animated: true)
    }
    
    private func uploadCameraPhoto() {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        
        imagePicker.allowsEditing = true
        
        imagePicker.delegate = self
        
        present(imagePicker, animated: true)
    }
    
    private func uploadImage() {
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = 0
        
        let pickerViewController = PHPickerViewController(configuration: configuration)
        
        pickerViewController.delegate = self
        
        present(pickerViewController, animated: true)
    }
    
    private func handleNewFileButtonTap(type: FilesUnitType = .folder) {
        switch type {
        case .folder:
            showAlert()
        case .image:
            uploadImage()
        case .photo:
            uploadCameraPhoto()
        }
    }

}

extension FilesViewController: FilesManagerServiceDelegate {
    func reloadData() {
        filesTableView.reloadData()
    }
}

extension FilesViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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

extension FilesViewController: PHPickerViewControllerDelegate {
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
