//
//  FilesCollectionViewCell.swift
//  FileManager
//
//  Created by Екатерина Неделько on 8.06.22.
//

import UIKit

final class FilesCollectionViewCell: UICollectionViewCell, FilesCell {
    
    static let id = "FilesCollectionViewCell"
    
    var fileImageView = UIImageView()
    var fileNameLabel = UILabel()

    var viewBackgroundColor: UIColor = .clear {
        didSet {
            backgroundColor = viewBackgroundColor
        }
    }
    
    private let verticalStack = UIStackView()
    private let layerView = UIView()
    
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
    
    func configureCell() {
        setupAppearance()
        addSubviews()
        configureLayout()
    }
    
}

// MARK: - Appearance Methods

private extension FilesCollectionViewCell {
    func setupAppearance() {
        verticalStack.axis = .vertical
        verticalStack.alignment = .center
        verticalStack.distribution = .fillEqually
        verticalStack.spacing = 5
        
        self.fileImageView.tintColor = .darkGray
        self.fileNameLabel.textColor = .darkGray
    }
    
    func addSubviews() {
        addSubview(verticalStack)
        verticalStack.addArrangedSubview(layerView)
        layerView.addSubview(fileImageView)
        verticalStack.addArrangedSubview(fileNameLabel)
    }
    
    func configureLayout() {
        verticalStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            verticalStack.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            verticalStack.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            verticalStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            verticalStack.topAnchor.constraint(equalTo: self.topAnchor, constant: 5)
        ])
        
        fileImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            fileImageView.centerXAnchor.constraint(equalTo: layerView.centerXAnchor),
            fileImageView.centerYAnchor.constraint(equalTo: layerView.centerYAnchor),
            fileImageView.leadingAnchor.constraint(equalTo: layerView.leadingAnchor),
            fileImageView.topAnchor.constraint(equalTo: layerView.topAnchor)
        ])
    }
}
