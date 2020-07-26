import Foundation


protocol UserProtocol {
    var name: String { get set }
    var email: String { get set }
    var isOnline: Bool { get set }
}

// User model
struct User: UserProtocol {
    var name: String
    var email: String
    var isOnline: Bool
}
