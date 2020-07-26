//
//  NetworkService.swift
//  Contacts
//
//  Created by Копаницкий Сергей on 7/25/20.
//  Copyright © 2020 Копаницкий Сергей. All rights reserved.
//

import UIKit

class NetworkService {
    
    private let request: URLRequest
    
    init(request: URLRequest) {
        self.request = request
    }
    
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
