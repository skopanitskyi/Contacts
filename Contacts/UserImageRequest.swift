//
//  UserImageRequest.swift
//  Contacts
//
//  Created by Копаницкий Сергей on 7/25/20.
//  Copyright © 2020 Копаницкий Сергей. All rights reserved.
//

import Foundation
import CryptoKit

enum UserImageRequest {
    
    case image(email: String, size: Int)
    
    public var request: URLRequest? {
        guard var components = URLComponents(string: baseUrl), let path = self.path else { return nil}
        components.path = path
        components.queryItems = queryComponents
        guard let url = components.url else { return nil }
        return URLRequest(url: url)
    }
    
    private var baseUrl: String {
        return "https://secure.gravatar.com"
    }
    
    private var path: String? {
        switch self {
        case .image(let email, _):
            guard let hash = getHash(email: email) else { return nil}
            return "/avatar/\(hash)"
        }
    }
    
    private struct ParameterKeys {
        public static let imageStyle = "d"
        public static let imageSize = "s"
    }
    
    private struct DefaultValues {
        public static let imageStyle = "monsterid"
    }
    
    private var parameters: [String: Any] {
        switch self {
        case .image(_, let size):
            let parameters: [String: Any] = [
                ParameterKeys.imageStyle : DefaultValues.imageStyle,
                ParameterKeys.imageSize : size
            ]
            return parameters
        }
    }
    
    private var queryComponents: [URLQueryItem] {
        var components = [URLQueryItem]()
        
        for parametr in parameters {
            components.append(URLQueryItem(name: parametr.key, value: "\(parametr.value)"))
        }
        
        return components
    }
    
    private func getHash(email: String) -> String? {
        guard let data = email.data(using: .utf8) else { return nil }
        let hash = Insecure.MD5.hash(data: data)
        return hash.map { String(format: "%02hhx", $0) }.joined()
    }
}
