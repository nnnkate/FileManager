//
//  FoldersTableViewCell.swift
//  FileManager
//
//  Created by Екатерина Неделько on 31.05.22.
//

import UIKit

class FilesTableViewCell: UITableViewCell, FilesCell {

    static let id = "FilesTableViewCell"
    
    var fileImageView = UIImageView()
    var fileNameLabel = UILabel()
    
    var viewBackgroundColor: UIColor = .clear {
        didSet {
            backgroundColor = viewBackgroundColor
        }
    }
    
    private let horizontalStack = UIStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupAppearance()
        addSubviews() 
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

// MARK: - Appearance Methods

private extension FilesTableViewCell {
    func setupAppearance() {
        self.backgroundColor = .clear
        
        horizontalStack.axis = .horizontal
        horizontalStack.spacing = 10
        
        fileNameLabel.font = fileNameLabel.font.withSize(30)
        fileNameLabel.textColor = .darkGray
        fileImageView.tintColor = .darkGray
    }
    
    func addSubviews() {
        addSubview(horizontalStack)
        horizontalStack.addArrangedSubview(fileImageView)
        horizontalStack.addArrangedSubview(fileNameLabel)
    }
    
    func configureLayout() {
        horizontalStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            horizontalStack.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            horizontalStack.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            horizontalStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            horizontalStack.topAnchor.constraint(equalTo: self.topAnchor, constant: 5)
        ])
        
        fileImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            fileImageView.widthAnchor.constraint(equalTo: fileImageView.heightAnchor)
        ])
    }
}

