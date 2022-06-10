//
//  FilesManagerServiceDelegate.swift
//  FileManager
//
//  Created by Екатерина Неделько on 5.06.22.
//

import Foundation
import UIKit

protocol FilesManagerServiceDelegate {
    var filesTableView: UITableView! { get set }
    var filesCollectionView: UICollectionView! { get set }
    
    func reloadData()
}
