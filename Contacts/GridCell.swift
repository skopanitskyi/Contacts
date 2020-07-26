//
//  ListLayoutCollectionViewCell.swift
//  Contacts
//
//  Created by Копаницкий Сергей on 5/27/20.
//  Copyright © 2020 Копаницкий Сергей. All rights reserved.
//

import UIKit

class GridCell: UICollectionViewCell {
    
    public var user: UserProtocol? {
        didSet {
            addInfo()
        }
    }
    
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
        image.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        
    }
    
    private func setConstraintForOnlineStatus() {
        self.contentView.addSubview(onlineStatus)
        onlineStatus.topAnchor.constraint(equalTo: image.topAnchor, constant: 30).isActive = true
        onlineStatus.leadingAnchor.constraint(equalTo: image.leadingAnchor, constant: 28).isActive = true
        onlineStatus.heightAnchor.constraint(equalToConstant: 10).isActive = true
        onlineStatus.widthAnchor.constraint(equalToConstant: 10).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addInfo() {
        guard let user = self.user, let request = UserImageRequest.image(email: user.email, size: 40).request else {
            return
        }
        onlineStatus.isHidden = user.isOnline
        NetworkService(request: request).downloadImage { image in
            DispatchQueue.main.async {
                self.image.image = image
            }
        }
    }
}

