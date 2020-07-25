//
//  ListLayoutCollectionViewCell.swift
//  Contacts
//
//  Created by Копаницкий Сергей on 5/27/20.
//  Copyright © 2020 Копаницкий Сергей. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    private let image: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 20
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let onlineStatus: UIView = {
        let view = UIView()
        view.backgroundColor = .green
        view.clipsToBounds = true
        view.layer.cornerRadius = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setConstraintForImage()
        setConstraintForOnlineStatus()
    }
    
    private func setConstraintForImage() {
        self.contentView.addSubview(image)
        image.heightAnchor.constraint(equalToConstant: 40).isActive = true
        image.widthAnchor.constraint(equalToConstant: 40).isActive = true
        image.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5).isActive = true
        image.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10).isActive = true

    }
    
    private func setConstraintForOnlineStatus() {
        self.contentView.addSubview(onlineStatus)
        onlineStatus.topAnchor.constraint(equalTo: image.topAnchor, constant: 30).isActive = true
        onlineStatus.leftAnchor.constraint(equalTo: image.leftAnchor, constant: 28).isActive = true
        onlineStatus.heightAnchor.constraint(equalToConstant: 10).isActive = true
        onlineStatus.widthAnchor.constraint(equalToConstant: 10).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func addInfo(user: User) {
        DispatchQueue.global(qos: .utility).async {
            let images = UsersData.getImage(size: 40, user: user)
            DispatchQueue.main.async {
                self.image.image = images
            }
        }
        onlineStatus.isHidden = user.isOnline ? false : true
    }
}

