//
//  FilesCell.swift
//  FileManager
//
//  Created by Екатерина Неделько on 8.06.22.
//

import Foundation
import UIKit

protocol FilesCell {
    var fileImageView: UIImageView! { get }
    var fileNameLabel: UILabel! { get }
    
    func updateData(file: FilesUnit)
}

extension FilesCell {
    func updateData(file: FilesUnit) {
        updateImage(file: file)
        
        self.fileNameLabel.text = file.name
    }
    
    private func updateImage(file: FilesUnit) {
        let image: UIImage?
        
        switch file.type {
        case .folder:
            image = UIImage(systemName: "folder.fill")
            
        case .image, .photo:
            guard let data = try? Data(contentsOf: file.path) else {
                return
            }
            
            image = UIImage(data: data)
        }
        
        self.fileImageView.image = image
    }
}