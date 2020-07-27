//
//  UserImageRequest.swift
//  Contacts
//
//  Created by Копаницкий Сергей on 7/25/20.
//  Copyright © 2020 Копаницкий Сергей. All rights reserved.
//

import Foundation
import CryptoKit

/// Generates a request to get data from the network
enum UserImageRequest {
    
    // MARK: - User image request cases
    
    case image(email: String, size: Int)
    
    // MARK: - Additional structs
    
    /// Parameter keys used in the request
    private struct ParameterKeys {
        public static let imageStyle = "d"
        public static let imageSize = "s"
    }
    
    /// Default values used in the request
    private struct DefaultValues {
        public static let imageStyle = "monsterid"
    }
    
    // MARK: - User image request variables
    
    /// Returns a request to get specific data
    public var request: URLRequest? {
        switch self {
        case .image:
            guard var components = URLComponents(string: baseUrl), let path = self.path else { return nil }
            components.path = path
            components.queryItems = queryComponents
            guard let url = components.url else { return nil }
            return URLRequest(url: url)
        }
    }
    
    /// Base url for making request
    private var baseUrl: String {
        return "https://secure.gravatar.com"
    }
    
    /// Path to get any data
    private var path: String? {
        switch self {
        case .image(let email, _):
            guard let hash = getHash(email: email) else { return nil }
            return "/avatar/\(hash)"
        }
    }
    
    /// Parameters used for the request:
    ///  - style of image
    ///  - size of image
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
    
    /// Creates query components that are used in the request
    private var queryComponents: [URLQueryItem] {
        var components = [URLQueryItem]()
        
        for parametr in parameters {
            components.append(URLQueryItem(name: parametr.key, value: "\(parametr.value)"))
        }
        
        return components
    }
    
    // MARK: - User image request methods
    
    /// Generates a hash value that is needed to download the image. The hash value is processed from the user's email.
    ///
    /// - Parameter email: Email of the user whose image will be uploaded
    private func getHash(email: String) -> String? {
        guard let data = email.data(using: .utf8) else { return nil }
        let hash = Insecure.MD5.hash(data: data)
        return hash.map { String(format: "%02hhx", $0) }.joined()
    }
}
