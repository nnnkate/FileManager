//
//  FilesManagerServiceDelegate.swift
//  FileManager
//
//  Created by Екатерина Неделько on 5.06.22.
//

import Foundation
import UIKit

protocol FilesManagerServiceDelegate {
    func reloadData()
    func handleViewTypeChange()
    func handleViewModeChange()
    func pushViewController(_ viewController: UIViewController)
}
