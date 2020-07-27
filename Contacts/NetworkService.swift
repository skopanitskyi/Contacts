//
//  NetworkService.swift
//  Contacts
//
//  Created by Копаницкий Сергей on 7/25/20.
//  Copyright © 2020 Копаницкий Сергей. All rights reserved.
//

import UIKit

/// Downloads some data from the network
class NetworkService {
    
    // MARK: - Class instances
    
    /// Request for receiving data
    private let request: URLRequest
    
    // MARK: - Class constructor
    
    /// Network service class constructor
    init(request: URLRequest) {
        self.request = request
    }
    
    // MARK: - Network Service class methods
    
    /// Downloads an image from the network at the specified request
    ///
    /// - Parameter completion: Stores uploaded image or nil
    public func downloadImage(completion: @escaping (UIImage?) -> Void) {
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            
            if let error = error {
                completion(nil)
                print(error)
                return
            }
            
            if let data = data {
                let image = UIImage(data: data)
                completion(image)
            }
        }.resume()
    }
}
