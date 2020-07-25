//
//  DetailedInfo.swift
//  Contacts
//
//  Created by Копаницкий Сергей on 5/26/20.
//  Copyright © 2020 Копаницкий Сергей. All rights reserved.
//

import UIKit

class DetailedInfo: UIViewController {
    
    public var user: User?
    
    private let layoutView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let avatar: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private let name: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.systemFont(ofSize: 30)
        textField.textAlignment = .center
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let onlineStatus: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.systemFont(ofSize: 20)
        textField.textAlignment = .center
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let email: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.systemFont(ofSize: 25)
        textField.textAlignment = .center
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayoutView()
        setupAvatar()
        setupName()
        setupOnlineStatus()
        setupEmail()
    }
    
    private func setupLayoutView() {
        view.addSubview(layoutView)
        layoutView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        layoutView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        layoutView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        layoutView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
    }
    
    
    private func setupAvatar() {
        layoutView.addSubview(avatar)
        
        DispatchQueue.global(qos: .utility).async {
            if let user = self.user {
                let image = UsersData.getImage(size: 175, user: user)
                DispatchQueue.main.async {
                    self.avatar.image = image
                }
            }
        }
        avatar.centerXAnchor.constraint(equalTo: layoutView.centerXAnchor).isActive = true
        avatar.centerYAnchor.constraint(equalTo: layoutView.centerYAnchor).isActive = true
        avatar.heightAnchor.constraint(equalTo: layoutView.heightAnchor, multiplier: 0.5).isActive = true
    }
    
    private func setupName() {
        name.text = user?.name
        view.addSubview(name)
        name.topAnchor.constraint(equalTo: avatar.bottomAnchor, constant: 15).isActive = true
        name.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        name.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        name.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    private func setupOnlineStatus() {
        
        if let isOnline = user?.isOnline {
            onlineStatus.text = isOnline ? "online" : "offline"
        }
        view.addSubview(onlineStatus)
        onlineStatus.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 10).isActive = true
        onlineStatus.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        onlineStatus.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        onlineStatus.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    private func setupEmail() {
        email.text = user?.email
        view.addSubview(email)
        email.topAnchor.constraint(equalTo: onlineStatus.bottomAnchor, constant: 10).isActive = true
        email.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        email.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        email.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
}
