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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        handleCellTap(indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        handleCellTap(indexPath: indexPath)
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension FilesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionCellSize
    }
}

//MARK: - UICollectionViewDataSource

extension FilesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return manager.filesData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let collectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: FilesCollectionViewCell.id,
                                                                          for: indexPath) as? FilesCollectionViewCell else {
            return UICollectionViewCell()
        }

        let file = manager.filesData[indexPath.row]
        collectionViewCell.updateData(file: file, selected: manager.selectedFiles.contains(file))
        
        return collectionViewCell
    }
}

