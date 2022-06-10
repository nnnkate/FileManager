//
//  FilesViewController+TableView.swift
//  FileManager
//
//  Created by Екатерина Неделько on 5.06.22.
//

import UIKit

extension FilesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        manager.openFile(file: manager.filesData[indexPath.row], navigationController: navigationController)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        manager.deleteFile(file: manager.filesData[indexPath.row])
     }
}

extension FilesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return manager.filesData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let filesTableViewCell = filesTableView.dequeueReusableCell(withIdentifier: FilesTableViewCell.id) as? FilesTableViewCell else {
            return UITableViewCell()
        }

        filesTableViewCell.updateData(file: manager.filesData[indexPath.row])
        
        return filesTableViewCell
    }
}
