//
//  FilesViewController+CollectionView.swift
//  FileManager
//
//  Created by Екатерина Неделько on 8.06.22.
//

import UIKit

extension FilesViewController {
    var collectionCellSize: CGSize {
        let size = 100
        
        return CGSize(width: size, height: size)
    }
    
    func setUpCollectionView() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 60, height: 60)
                
        filesCollectionView = UICollectionView(frame: view.frame, collectionViewLayout: layout)
        
        filesCollectionView.backgroundColor = UIColor.clear
        
        filesCollectionView.delegate = self
        filesCollectionView.dataSource = self
        
        filesCollectionView.register(FilesCollectionViewCell.self,
                                     forCellWithReuseIdentifier: FilesCollectionViewCell.id)
        
        view.addSubview(filesCollectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        manager.openFile(file: manager.filesData[indexPath.row], navigationController: navigationController)
    }
}

extension FilesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionCellSize
    }
}

extension FilesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return manager.filesData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let collectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: FilesCollectionViewCell.id, for: indexPath) as? FilesCollectionViewCell else {
            return UICollectionViewCell()
        }

        collectionViewCell.updateData(file: manager.filesData[indexPath.row])
        
        return collectionViewCell
    }
}

