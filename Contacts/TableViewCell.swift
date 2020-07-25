//
//  TableViewCell.swift
//  Contacts
//
//  Created by Копаницкий Сергей on 5/31/20.
//  Copyright © 2020 Копаницкий Сергей. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    let onlineStatus: UIView = {
        let view = UIView(frame: CGRect(x: 45, y: 35, width: 10, height: 10))
        view.layer.cornerRadius = 5
        view.backgroundColor = .green
        return view
    }()
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        addSubview(onlineStatus)
    }
    
    public func setHidden(online: Bool) {
        onlineStatus.isHidden = !online
    }
}
