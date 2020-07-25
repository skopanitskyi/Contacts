//
//  Main.swift
//  Contacts
//
//  Created by Копаницкий Сергей on 5/25/20.
//  Copyright © 2020 Копаницкий Сергей. All rights reserved.
//

import UIKit

class Main: UIViewController {
    
    private let list = List()
    private let grid = Grid()
    private let segmentedControl = UISegmentedControl(items: ["List", "Grid"])

    private let button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Simulate Changes", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSegmentedControl()
        addChildControllers()
        setupButton()
    }
    
    private func addChildControllers() {
        addChild(list)
        addChild(grid)
        view.addSubview(list.view)
        view.addSubview(grid.view)
        list.didMove(toParent: self)
        grid.didMove(toParent: self)
        grid.view.isHidden = true
    }

    private func setupButton() {
        view.addSubview(button)
        button.addTarget(self, action: #selector(changeUserData), for: .touchUpInside)
        button.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        button.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        button.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -15).isActive = true
    }

    private func setupSegmentedControl() {
        segmentedControl.setWidth(100, forSegmentAt: 0)
        segmentedControl.setWidth(100, forSegmentAt: 1)
        segmentedControl.selectedSegmentIndex = 0
        navigationItem.titleView = segmentedControl
        segmentedControl.addTarget(self, action: #selector(changeLayout(_:)), for: .valueChanged)
    }
    
    @objc private func changeLayout(_ segmentedControll: UISegmentedControl) {
        UsersData.mixUsers()
        if segmentedControll.selectedSegmentIndex == 0 {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "tableView"), object: nil)
            list.view.isHidden = false
            grid.view.isHidden = true
        } else {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "collectionView"), object: nil)
            list.view.isHidden = true
            grid.view.isHidden = false
        }
    }
    
    @objc private func changeUserData() {
        UsersData.changeData()
    }
}
