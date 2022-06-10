//
//  FilesViewController+TableView.swift
//  FileManager
//
//  Created by Екатерина Неделько on 5.06.22.
//

import UIKit

extension FilesViewController: UITableViewDelegate {
    func setUpTableView() {
        filesTableView = UITableView()
        
        filesTableView.backgroundColor = UIColor.clear
        
        filesTableView.delegate = self
        filesTableView.dataSource = self
        
        filesTableView.register(FilesTableViewCell.classForCoder(),
                                forCellReuseIdentifier: FilesTableViewCell.id)
        
        view.addSubview(filesTableView)
        
        filesTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            filesTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            filesTableView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            filesTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            filesTableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20)
        ])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        manager.openFile(file: manager.filesData[indexPath.row], navigationController: navigationController)
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
