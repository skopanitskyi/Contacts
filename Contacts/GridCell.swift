//
//  GridCell.swift
//  Contacts
//
//  Created by Копаницкий Сергей on 5/27/20.
//  Copyright © 2020 Копаницкий Сергей. All rights reserved.
//

import UIKit

/// A cell that displays users in a grid view
class GridCell: UICollectionViewCell {
    
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
    
    // MARK: - Class constructors
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupUserImageConstraints()
        setupOnlineStatusConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Add UI elements and setup constraints
    
    /// Add a user image on view and set constraints
    private func setupUserImageConstraints() {
        contentView.addSubview(userImage)
        userImage.heightAnchor.constraint(equalToConstant: 40).isActive = true
        userImage.widthAnchor.constraint(equalToConstant: 40).isActive = true
        userImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        userImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5).isActive = true
        
    }
    
    /// Add a online status on view and set constraints
    private func setupOnlineStatusConstraints() {
        contentView.addSubview(onlineStatus)
        onlineStatus.topAnchor.constraint(equalTo: userImage.topAnchor, constant: 30).isActive = true
        onlineStatus.leadingAnchor.constraint(equalTo: userImage.leadingAnchor, constant: 28).isActive = true
        onlineStatus.heightAnchor.constraint(equalToConstant: 10).isActive = true
        onlineStatus.widthAnchor.constraint(equalToConstant: 10).isActive = true
    }
    
    // MARK: - Class methods
    
    /// Adds information about a user to a cell
    private func addInfo() {
        guard let user = self.user, let request = UserImageRequest.image(email: user.email, size: imageSize).request else {
            return
        }
        onlineStatus.isHidden = !user.isOnline
        NetworkService(request: request).downloadImage { image in
            DispatchQueue.main.async {
                self.userImage.image = image
            }
        }
    }
}
