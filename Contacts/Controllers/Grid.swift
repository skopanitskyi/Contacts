//
//  Grid.swift
//  Contacts
//
//  Created by Копаницкий Сергей on 5/28/20.
//  Copyright © 2020 Копаницкий Сергей. All rights reserved.
//

import UIKit

class Grid: UIViewController {
    
    private let collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect(), collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        NotificationCenter.default.addObserver(self, selector: #selector(reloadCollectionView),
                                               name: NSNotification.Name(rawValue: "collectionView"), object: nil)
    }
    
    private func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.contentInsetAdjustmentBehavior = .always
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
    }
    
    @objc private func reloadCollectionView() {
        self.collectionView.reloadData()
    }
    
    private func moveUserToAnotherCell(oldIndex: Int) {
        let newIndex = Int.random(in: 0..<UsersData.users.count-1)
        UsersData.replaceUser(oldIndex: oldIndex, newIndex: newIndex)
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

//MARK: CollectionViewDelegate
extension Grid: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let user = UsersData.users[indexPath.row]
        let secondViewController = storyboard.instantiateViewController(withIdentifier: "DetailedInfo") as! DetailedInfo
        secondViewController.modalPresentationStyle = .fullScreen
        secondViewController.user = user
        self.navigationController?.pushViewController(secondViewController, animated: true)
        moveUserToAnotherCell(oldIndex: indexPath.row)
    }
}

//MARK: CollectionViewDataSource
extension Grid: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return UsersData.users.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        let user = UsersData.users[indexPath.row]
        cell.addInfo(user: user)
        return cell
    }
}

// MARK:  CollectionViewDelegateFlowLayout
extension Grid: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
}
