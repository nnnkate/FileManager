//
//  ViewController.swift
//  FileManager
//
//  Created by Екатерина Неделько on 31.05.22.
//

import UIKit
import PhotosUI

final class FilesViewController: UIViewController {
    
    // MARK: - Public Properties
    
    lazy var filesTableView: UITableView = {
        let filesTableView = UITableView()
        
        filesTableView.delegate = self
        filesTableView.dataSource = self
    
        filesTableView.register(FilesTableViewCell.classForCoder(),
                        forCellReuseIdentifier: FilesTableViewCell.id)
    
        return filesTableView
    }()
  
    lazy var filesCollectionView: UICollectionView = {
        filesCollectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        
        filesCollectionView.delegate = self
        filesCollectionView.dataSource = self
        
        filesCollectionView.register(FilesCollectionViewCell.self,
                                     forCellWithReuseIdentifier: FilesCollectionViewCell.id)
        
        return filesCollectionView
    }()
    
    let manager = FilesManagerService()
    
    // MARK: - Private properties
    
    private let layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 60, height: 60)
        
        return layout
    }()
    
    private var mainMenuItems: [UIMenuElement] {
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
    
    private var switchInterfaceItems: [UIAction] {
        return [
            UIAction(title: ViewType.list.rawValue,
                     image: UIImage(systemName: "list.bullet"),
                     state: manager.viewType == .list ? .on : .off,
                     handler: { _ in
                         UserDefaults.standard.set(ViewType.list.rawValue, forKey: ViewType.settingName)
                         self.manager.viewType = .list
            }),
            UIAction(title: ViewType.icons.rawValue,
                     image: UIImage(systemName: "rectangle.grid.2x2"),
                     state: manager.viewType == .icons ? .on : .off,
                     handler: { _ in
                         UserDefaults.standard.set(ViewType.icons.rawValue, forKey: ViewType.settingName)
                         self.manager.viewType = .icons
            })
        ]
    }

    private var mainMenu: UIMenu {
        return UIMenu(title: "Menu", children: mainMenuItems)
    }
    
    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
  
        manager.delegate = self
        
        setupAppearance()
        addSubviews()
        configureLayout()
        
        setUpNavigationBar()
        
        manager.updateFilesData()
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
    
    func handleViewTypeChange() {
        switch manager.viewType {
        case .list:
            filesTableView.isHidden = false
            filesCollectionView.isHidden = true
            
        case .icons:
            filesTableView.isHidden = true
            filesCollectionView.isHidden = false
        }
        self.setUpNavigationBar()
    }

}

// MARK: - FilesManagerServiceDelegate

extension FilesViewController: FilesManagerServiceDelegate {
    func reloadData() {
        DispatchQueue.main.async {
            self.filesTableView.reloadData()
            self.filesCollectionView.reloadData()
        }
    }
}

// MARK: - Appearance Methods

private extension FilesViewController {
    private func setUpNavigationBar() {
        let rightBarButtonItem = UIBarButtonItem(title: nil, image: UIImage(systemName: "ellipsis.circle"), primaryAction: nil, menu: mainMenu)
        
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    private func setupAppearance() {
        let viewTypeSetting = UserDefaults.standard.string(forKey: ViewType.settingName)
        manager.viewType = viewTypeSetting == ViewType.icons.rawValue ? .icons : .list
        
        filesTableView.backgroundColor = UIColor.clear
        filesCollectionView.backgroundColor = UIColor.clear
    }
    
    private func addSubviews() {
        view.addSubview(filesTableView)
        view.addSubview(filesCollectionView)
    }
    
    private func configureLayout() {
        filesTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            filesTableView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            filesTableView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            filesTableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            filesTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10)
        ])
    }
}

