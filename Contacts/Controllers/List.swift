//
//  List.swift
//  Contacts
//
//  Created by Копаницкий Сергей on 5/28/20.
//  Copyright © 2020 Копаницкий Сергей. All rights reserved.
//

import UIKit

class List: UIViewController {
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "Cell")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTableView),
                                               name: NSNotification.Name(rawValue: "tableView"), object: nil)
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
    }
    
    @objc private func reloadTableView() {
        self.tableView.reloadData()
    }
    
    private func moveUserToAnotherCell(oldIndex: Int) {
        let newIndex = Int.random(in: 0..<UsersData.users.count-1)
        UsersData.replaceUser(oldIndex: oldIndex, newIndex: newIndex)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

//MARK: TableViewDelegate
extension List: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let secondViewController = storyboard.instantiateViewController(withIdentifier: "DetailedInfo") as! DetailedInfo
        secondViewController.modalPresentationStyle = .fullScreen
        secondViewController.user = UsersData.users[indexPath.row]
        self.navigationController?.pushViewController(secondViewController, animated: true)
        moveUserToAnotherCell(oldIndex: indexPath.row)
    }
}

//MARK: TableViewDataSource
extension List: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UsersData.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        let user = UsersData.users[indexPath.row]
        cell.setHidden(online: user.isOnline)
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = user.name
        cell.imageView?.layer.cornerRadius = 20
        cell.imageView?.clipsToBounds = true
        
        DispatchQueue.global(qos: .userInteractive).async {
            let image = UsersData.getImage(size: 40, user: user)
            DispatchQueue.main.async {
                cell.imageView?.image = image
                tableView.beginUpdates()
                tableView.endUpdates()
            }
        }
        return cell
    }
}
