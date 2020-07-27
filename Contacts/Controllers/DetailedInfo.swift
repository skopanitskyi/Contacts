//
//  DetailedInfo.swift
//  Contacts
//
//  Created by Копаницкий Сергей on 5/26/20.
//  Copyright © 2020 Копаницкий Сергей. All rights reserved.
//

import UIKit

/// Detailed info controller, that displays complete information about the user
class DetailedInfo: UIViewController {
    
    // MARK: - Class instances
    
    /// User whose detailed information will be displayed
    public var user: UserProtocol? {
        didSet {
            setupUserData()
        }
    }
    
    // MARK: - Create UI elements
    
    /// Create a layout view to which the image will be added
    private let layoutView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    /// Create user avatar image view
    private let userAvatar: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    /// Create user name label
    private let userName: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 30)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    /// Create user online status label
    private let userOnlineStatus: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    /// Create user email label
    private let userEmail: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 25)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Detailed info controller life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayoutView()
        setupUserAvatarConstraints()
        setupUserNameConstraints()
        setupUserOnlineStatusConstraints()
        setupUserEmailConstraints()
    }
    
    // MARK: - Add UI elements and setup constraints
    
    /// Add a layout view on view and set constraints
    private func setupLayoutView() {
        view.addSubview(layoutView)
        layoutView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        layoutView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        layoutView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        layoutView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
    }
    
    /// Add a user avatar on view and set constraints
    private func setupUserAvatarConstraints() {
        layoutView.addSubview(userAvatar)
        userAvatar.centerXAnchor.constraint(equalTo: layoutView.centerXAnchor).isActive = true
        userAvatar.centerYAnchor.constraint(equalTo: layoutView.centerYAnchor).isActive = true
        userAvatar.heightAnchor.constraint(equalTo: layoutView.heightAnchor, multiplier: 0.5).isActive = true
    }
    
    /// Add a user name label on view and set constraints
    private func setupUserNameConstraints() {
        view.addSubview(userName)
        userName.topAnchor.constraint(equalTo: userAvatar.bottomAnchor, constant: 15).isActive = true
        userName.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        userName.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        userName.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    /// Add a online status label on view and set constraints
    private func setupUserOnlineStatusConstraints() {
        view.addSubview(userOnlineStatus)
        userOnlineStatus.topAnchor.constraint(equalTo: userName.bottomAnchor, constant: 10).isActive = true
        userOnlineStatus.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        userOnlineStatus.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        userOnlineStatus.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    /// Add a user email label on view and set constraints
    private func setupUserEmailConstraints() {
        view.addSubview(userEmail)
        userEmail.topAnchor.constraint(equalTo: userOnlineStatus.bottomAnchor, constant: 10).isActive = true
        userEmail.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        userEmail.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        userEmail.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    // MARK: - Class methods
    
    /// Adds information about a user on view
    private func setupUserData() {
        guard let user = self.user, let request = UserImageRequest.image(email: user.email, size: 200).request else {
            return
        }
        userName.text = user.name
        userEmail.text = user.email
        userOnlineStatus.text = user.isOnline ? "online" : "offline"
        NetworkService(request: request).downloadImage { image in
            DispatchQueue.main.async {
                self.userAvatar.image = image
            }
        }
    }
}
