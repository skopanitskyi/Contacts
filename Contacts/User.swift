import Foundation

/// User protocol
protocol UserProtocol {
    var name: String { get set }
    var email: String { get set }
    var isOnline: Bool { get set }
}

/// User data model
struct User: UserProtocol {
   public var name: String
   public var email: String
   public var isOnline: Bool
}
