//
//  FilesManagerService.swift
//  FileManager
//
//  Created by Екатерина Неделько on 5.06.22.
//

import Foundation
import UIKit

final class FilesManagerService {
    
    // MARK: - Public Properties
    
    var viewMode: ViewMode = .view {
        didSet {
            delegate?.handleViewModeChange()
        }
    }
    
    var viewType: ViewType = .list {
        didSet {
            delegate?.handleViewTypeChange()
        }
    }
    
    var currentDirectory = FileManager.default.urls(for: .documentDirectory,
                                                    in: .userDomainMask).first
    
    var filesData = [FilesUnit]() {
        didSet {
            filesData.sort { $1.name > $0.name }
            filesData.sort { $1.type.sortPriority > $0.type.sortPriority }
        }
    }
    
    var selectedFiles = [FilesUnit]()
    
    weak var delegate: FilesManagerServiceDelegate?
    
    // MARK: - Private properties
    
    private let fileManager = FileManager.default
    
    // MARK: - Files handling methods
    
    func updateFilesData() {
        guard let currentDirectory = currentDirectory,
              let contents = try? FileManager.default.contentsOfDirectory(at: currentDirectory, includingPropertiesForKeys: nil)  else { return }
        
        filesData = contents.map {
            let name = $0.lastPathComponent
            
            return FilesUnit(name: name,
                             path: $0,
                             type: name.contains(".png") || name.contains(".jpeg") ? .image : .folder)
        }
        
        delegate?.reloadData()
    }
    
    func addDirectory(name: String) {
        guard let currentDirectory = currentDirectory else { return }
        
        let filePath = currentDirectory.appendingPathComponent(name)
        if !fileManager.fileExists(atPath: filePath.path) {
            do {
                try fileManager.createDirectory(atPath: filePath.path,
                                                withIntermediateDirectories: false,
                                                attributes: nil)
                updateFilesData()
            } catch {
                print("Error")
            }
        }
    }
    
    func createImage(_ image: UIImage, name: String) {
        guard let currentDirectory = self.currentDirectory,
              let data = image.jpegData(compressionQuality: 1) else { return }
        
        let newImagePath = currentDirectory.appendingPathComponent(name)
        
        try? data.write(to: newImagePath)
        
        updateFilesData()
    }

    func openFile(file: FilesUnit, navigationController: UINavigationController?) {
        let newDirectory = file.path
        
        switch file.type {
        case .folder:
            let selectFolderViewContoller = FilesViewController()
            selectFolderViewContoller.manager.currentDirectory = newDirectory
            delegate?.pushViewController(selectFolderViewContoller)

        default:
            let selectImageViewContoller = ImageViewController()
            if let data = try? Data(contentsOf: newDirectory) {
                selectImageViewContoller.image = UIImage(data: data)
            }
            delegate?.pushViewController(selectImageViewContoller)
 
        }
    }
    
    func deleteFile(file: FilesUnit) {
        try? FileManager.default.removeItem(at: file.path)
        
        updateFilesData()
    }
    
    func deleteFiles() {
        guard viewMode == .select else { return }
        
        for file in selectedFiles {
            try? FileManager.default.removeItem(at: file.path)
        }
        
        viewMode = .view
        
        updateFilesData()
    }
    
    func selectFile(file: FilesUnit) {
        guard viewMode == .select else { return }
        
        if let index = selectedFiles.firstIndex(of: file) {
            selectedFiles.remove(at: index)
        }
        else {
            selectedFiles.append(file)
        }
        
        delegate?.reloadData()
    }
    
    func handleSelectionCompleted() {
        selectedFiles.removeAll()
        delegate?.reloadData()
    }
    
    // MARK: - Settings handling methods
    
    func setViewTypeSetting(_ viewType: ViewType) {
        UserDefaults.standard.set(viewType.rawValue, forKey: ViewType.settingName)
        self.viewType = viewType
    }
}

