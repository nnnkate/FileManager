//
//  FoldersTableViewCell.swift
//  FileManager
//
//  Created by Екатерина Неделько on 31.05.22.
//

import UIKit

class FilesTableViewCell: UITableViewCell, FilesCell {

    static let id = "FilesTableViewCell"
    
    var fileImageView: UIImageView!
    var fileNameLabel: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureCell()
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
    
    private func configureCell() {
        self.backgroundColor = .clear
        
        let horizontalStack = UIStackView()
        horizontalStack.axis = .horizontal
        horizontalStack.spacing = 10
        
        addSubview(horizontalStack)
        
        horizontalStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            horizontalStack.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            horizontalStack.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            horizontalStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            horizontalStack.topAnchor.constraint(equalTo: self.topAnchor, constant: 5)
        ])
        
        let fileImageView = UIImageView()
        self.fileImageView = fileImageView
        
        horizontalStack.addArrangedSubview(fileImageView)
        
        NSLayoutConstraint.activate([
            fileImageView.widthAnchor.constraint(equalTo: fileImageView.heightAnchor)
        ])
        
        let fileNameLabel = UILabel()
        fileNameLabel.font = fileNameLabel.font.withSize(30)
        self.fileNameLabel = fileNameLabel
        
        horizontalStack.addArrangedSubview(fileNameLabel)
        
        fileImageView.tintColor = .white
        fileNameLabel.textColor = .white
    }
}
