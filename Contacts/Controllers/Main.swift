//
//  Main.swift
//  Contacts
//
//  Created by Копаницкий Сергей on 5/25/20.
//  Copyright © 2020 Копаницкий Сергей. All rights reserved.
//

import UIKit

/// The main controller that displays the list of users
class Main: UIViewController {
    
    // MARK: - Class instances
    
    /// Singleton object of class User Data
    private let userData = UsersData.shared
    
    /// Padding which is used for collection view cell
    private let padding: CGFloat = 5
    
    /// Reuse identifier which is used for the list cell
    private let listReuseIdentifier = "List"
    
    /// Reuse identifier which is used for the grid cell
    private let gridReuseIdentifier = "Grid"
    
    // MARK: - Create UI elements
    
    /// Create simulate changes button
    private let button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Simulate Changes", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    /// Create segmented control
    private let segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl(items: ["List", "Grid"])
        segmentedControl.setWidth(100, forSegmentAt: 0)
        segmentedControl.setWidth(100, forSegmentAt: 1)
        segmentedControl.selectedSegmentIndex = 0
        return segmentedControl
    }()
    
    /// Create collection view
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    // MARK: - Main controller life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(reloadData),
                                               name: .init(UsersData.notificationName), object: nil)
        view.backgroundColor = .white
        setupButtonConstraints()
        setupSegmentedControl()
        setupCollectionViewConstraints()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        guard let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }
        flowLayout.invalidateLayout()
    }
    
    // MARK: - Add UI elements and setup constraints
    
    /// Add a button on view and set constraints
    private func setupButtonConstraints() {
        view.addSubview(button)
        button.addTarget(self, action: #selector(changeUserData), for: .touchUpInside)
        button.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        button.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -15).isActive = true
    }
    
    /// Add a segmented control at navigation controller
    private func setupSegmentedControl() {
        segmentedControl.addTarget(self, action: #selector(changeLayout(_:)), for: .valueChanged)
        navigationItem.titleView = segmentedControl
    }
    
    /// Add a collection view on view and set constraints
    private func setupCollectionViewConstraints() {
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(GridCell.self, forCellWithReuseIdentifier: gridReuseIdentifier)
        collectionView.register(ListCell.self, forCellWithReuseIdentifier: listReuseIdentifier)
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: button.topAnchor, constant: -10).isActive = true
    }
    
    // MARK: - Class methods
    
    /// Updates the collection view after changing the model or layout
    @objc private func reloadData() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    /// Modifies layout and sorts the user array
    ///
    /// - Parameter segmentedControll: Segmented controll object
    @objc private func changeLayout(_ segmentedControll: UISegmentedControl) {
        userData.sortsUsers()
    }
    
    /// Changes the user model randomly
    @objc private func changeUserData() {
        userData.changeData()
    }
}

// MARK: - CollectionViewDelegate

extension Main: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailedInfoController = DetailedInfo()
        detailedInfoController.user = userData.users[indexPath.row]
        navigationController?.pushViewController(detailedInfoController, animated: true)
        userData.replaceUser(at: indexPath.row)
    }
}

// MARK: - CollectionViewDataSource

extension Main: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userData.users.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let user = userData.users[indexPath.row]
        
        if segmentedControl.selectedSegmentIndex == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: listReuseIdentifier, for: indexPath) as? ListCell else { return UICollectionViewCell() }
            cell.user = user
            return cell
        }
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: gridReuseIdentifier, for: indexPath) as? GridCell else { return UICollectionViewCell() }
        cell.user = user
        return cell
    }
}

// MARK: - CollectionViewDelegateFlowLayout

extension Main: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if segmentedControl.selectedSegmentIndex == 0 {
            return CGSize(width: view.bounds.width - 2 * padding, height: 50)
        }
        return CGSize(width: 50, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
    }
}
