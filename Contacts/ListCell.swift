//
//  ListCell.swift
//  Contacts
//
//  Created by Копаницкий Сергей on 7/25/20.
//  Copyright © 2020 Копаницкий Сергей. All rights reserved.
//

import UIKit

/// A cell that displays users in a list view
class ListCell: UICollectionViewCell {
    
    // MARK: - Class instances
    
    /// Size of the image to be loaded
    private let imageSize: Int = 40
    
    /// The user to be displayed in the cell
    public var user: UserProtocol? {
        didSet {
            addInfo()
        }
    }
    
    // MARK: - Create UI elements
    
    /// Create user image view
    private let userImage: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 20
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    /// Create online status view
    private let onlineStatus: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        view.clipsToBounds = true
        view.layer.cornerRadius = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    /// Create user name label
    private let userName: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Class constructors
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUserImageConstraints()
        setupOnlineStatusConstraints()
        setupUserNameConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Add UI elements and setup constraints
    
    /// Add a user image on view and set constraints
    private func setupUserImageConstraints() {
        contentView.addSubview(userImage)
        userImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        userImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        userImage.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5).isActive = true
        userImage.widthAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    /// Add a online status on view and set constraints
    private func setupOnlineStatusConstraints() {
        contentView.addSubview(onlineStatus)
        onlineStatus.topAnchor.constraint(equalTo: userImage.topAnchor, constant: 30).isActive = true
        onlineStatus.leadingAnchor.constraint(equalTo: userImage.leadingAnchor, constant: 28).isActive = true
        onlineStatus.heightAnchor.constraint(equalToConstant: 10).isActive = true
        onlineStatus.widthAnchor.constraint(equalToConstant: 10).isActive = true
    }
    
    /// Add a user name on view and set constraints
    private func setupUserNameConstraints() {
        contentView.addSubview(userName)
        userName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 17).isActive = true
        userName.leadingAnchor.constraint(equalTo: userImage.trailingAnchor, constant: 10).isActive = true
        userName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        userName.heightAnchor.constraint(equalToConstant: 15).isActive = true
    }
    
    // MARK: - Class methods
    
    /// Adds information about a user to a cell
    private func addInfo() {
        guard let user = self.user, let request = UserImageRequest.image(email: user.email, size: imageSize).request else {
            return
        }
        userName.text = user.name
        onlineStatus.isHidden = !user.isOnline
        NetworkService(request: request).downloadImage { image in
            DispatchQueue.main.async {
                self.userImage.image = image
            }
        }
    }
}
