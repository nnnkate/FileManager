//
//  FilesCollectionViewCell.swift
//  FileManager
//
//  Created by Екатерина Неделько on 8.06.22.
//

import UIKit

class FilesCollectionViewCell: UICollectionViewCell, FilesCell {
    
    static let id = "FilesCollectionViewCell"
    
    var fileImageView: UIImageView!
    var fileNameLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureCell()
    }

    private func configureCell() {
        let verticalStack = UIStackView()
        verticalStack.axis = .vertical
        verticalStack.alignment = .center
        verticalStack.distribution = .fillProportionally
        verticalStack.spacing = 5
        
        addSubview(verticalStack)
        
        verticalStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            verticalStack.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            verticalStack.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            verticalStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            verticalStack.topAnchor.constraint(equalTo: self.topAnchor, constant: 5)
        ])
        
        let imageView = UIImageView()
        self.fileImageView = imageView
        self.fileImageView.tintColor = .white
        
        verticalStack.addArrangedSubview(imageView)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor)
        ])
     
        let label = UILabel()
        self.fileNameLabel = label
        self.fileNameLabel.textColor = .white
        
        verticalStack.addArrangedSubview(label)
    }
}
