//
//  FilesUnit.swift
//  FileManager
//
//  Created by Екатерина Неделько on 5.06.22.
//

import Foundation

struct FilesUnit {
    let name: String
    let path: URL
    
    let type: FilesUnitType
}

enum FilesUnitType {
    case folder
    case image
    case photo
    
    var sortPriority: Int {
        switch self {
        case .folder:
            return 0
            
        case .image, .photo:
            return 1
        }
    }
}
