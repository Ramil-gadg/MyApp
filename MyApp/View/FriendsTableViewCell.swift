//
//  FriendsTableViewCell.swift
//  MyApp
//
//  Created by Рамил Гаджиев on 20.09.2021.
//

import UIKit

class FriendsTableViewCell: UITableViewCell {

    let cell: UIView = {
       let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        return view
    }()
    
    var fullName: UILabel = {
        let label = UILabel()
        label.text = "label"
        label.numberOfLines = 1
        label.font = UIFont.regularFont(size: 13)
        label.textColor = .text()
        return label
    }()
    
    var bestFriendLabel: UIImageView = {
        let image = UIImageView()
        image.sizeToFit()
       // image.image = UIImage(systemName: "hand.thumbsup.fill")
        image.tintColor = .text()
        return image
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setUpCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpCell() {
        cell.translatesAutoresizingMaskIntoConstraints = false
        fullName.translatesAutoresizingMaskIntoConstraints = false
        bestFriendLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(cell)
        cell.addSubview(fullName)
        cell.addSubview(bestFriendLabel)
        
        NSLayoutConstraint.activate([
            cell.topAnchor.constraint(equalTo: contentView.topAnchor),
            cell.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            cell.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cell.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            fullName.topAnchor.constraint(equalTo: cell.topAnchor),
            fullName.bottomAnchor.constraint(equalTo: cell.bottomAnchor),
            fullName.leadingAnchor.constraint(equalTo: cell.leadingAnchor, constant: 10),
            
            bestFriendLabel.topAnchor.constraint(equalTo: cell.topAnchor, constant: 5),
            bestFriendLabel.bottomAnchor.constraint(equalTo: cell.bottomAnchor, constant: -5),
            bestFriendLabel.trailingAnchor.constraint(equalTo: cell.trailingAnchor, constant: -10)
        ])
        
    }
    
    
}
