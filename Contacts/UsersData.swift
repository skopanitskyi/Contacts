import UIKit

/// Stores user data and methods for processing them
class UsersData {
    
    // MARK: - Class instances
    
    /// Singleton object of class User Data
    public static let shared = UsersData()
    
    /// Notification name used to call the collection view update method
    public static let notificationName = "reloadCollectionView"
    
    /// Array of users that are displayed after launch
    public var users = [User(name: "Serhii", email: "serhii@gmail.com", isOnline: true),
                        User(name: "Aleksandr", email: "aleksandr@gmail.com", isOnline: false),
                        User(name: "Anatoly", email: "anatoly@gmail.com", isOnline: true),
                        User(name: "Andrey", email: "andrey@gmail.com", isOnline: true),
                        User(name: "Anton", email: "anton@gmail.com", isOnline: false),
                        User(name: "Artur", email: "artur@gmail.com", isOnline: true),
                        User(name: "Boris", email: "boris@gmail.com", isOnline: false),
                        User(name: "Vadim", email: "vadim@gmail.com", isOnline: true),
                        User(name: "Valentin", email: "valentin@gmail.com", isOnline: false),
                        User(name: "Valeriy", email: "valeriy@gmail.com", isOnline: true),
                        User(name: "Ihor", email: "ihor@gmail.com", isOnline: true),
                        User(name: "Denis", email: "denis@gmail.com", isOnline: true),
                        User(name: "Max", email: "max@gmail.com", isOnline: true)]
    
    /// An array of names used to create new users
    private let names = ["Vyacheslav", "Gennady", "Georgy", "Gleb", "Grigory", "Daniil", "Denis", "Dmitry", "Yevgeny",
                         "Yegor", "Zakhar", "Ivan", "Ilya", "Innokenty", "Iosif", "Kirill", "Konstantin", "Lev",
                         "Leonid", "Maksim", "Matvey", "Mikhail", "Moisey", "Nikita", "Nikolay", "Oleg", "Pavel",
                         "Pyotr", "Roman", "Ruslan", "Svyatoslav", "Semyon", "Stanislav", "Stepan", "Timofey",
                         "Timur","Fedor", "Filipp", "Eduard", "Yuri", "Yakov", "Yan", "Yaroslav", "Aleksandra", "Alisa"]
    
    // MARK: - Class constructor
    
    /// User Data class constructor
    private init() { }
    
    // MARK: - User Data class methods
    
    /// Randomly changes the data model on a background thread
    public func changeData() {
        DispatchQueue.global(qos: .userInitiated).async {
            self.changeOnlineStatus()
            self.changeNamesAndEmails()
            self.addOrRemoveUsers()
            NotificationCenter.default.post(name: .init(UsersData.notificationName), object: nil)
        }
    }
    
    /// Randomly changes the online status of each user
    private func changeOnlineStatus() {
        for i in 0..<users.count {
            users[i].isOnline = Bool.random()
        }
    }
    
    /// Randomly selects users and changes their names and email
    private func changeNamesAndEmails() {
        let number = Int.random(in: 0..<users.count)
        
        for _ in 0..<number {
            let indexUsers = Int.random(in: 0..<users.count)
            let indexNames = Int.random(in: 0..<names.count)
            users[indexUsers].name = names[indexNames]
            users[indexUsers].email = "\(names[indexNames])@gmail.com"
        }
    }
    
    /// Adds or removes a random number of users
    private func addOrRemoveUsers() {
        let count = Int.random(in: 0..<users.count)
        
        for _ in 0..<count {
            Bool.random() ? removeUser() : addUser()
        }
    }
    
    /// Removes a random user from an array of users
    private func removeUser() {
        let indexUsers = Int.random(in: 0..<users.count)
        users.remove(at: indexUsers)
    }
    
    /// Adds a user to an array of users
    private func addUser() {
        let index = Int.random(in: 0..<names.count)
        let name = names[index]
        let email = "\(name)@gmail.com"
        users.append(User(name: name, email: email, isOnline: Bool.random()))
    }
    
    /// Change the location of the user in the array after viewing additional information about him
    ///
    /// - Parameter index: User index in the users array
    public func replaceUser(at index: Int) {
        DispatchQueue.global(qos: .userInitiated).async {
            let user = self.users.remove(at: index)
            let newIndex = Int.random(in: 0..<self.users.count)
            self.users.insert(user, at: newIndex)
            NotificationCenter.default.post(name: .init(UsersData.notificationName), object: nil)
        }
    }
    
    /// Sorts an array of users randomly after moving between a grid and a list cell
    public func sortsUsers() {
        DispatchQueue.global(qos: .userInitiated).async {
            for i in 0..<self.users.count {
                let user = self.users.remove(at: i)
                let newIndex = Int.random(in: 0..<self.users.count)
                self.users.insert(user, at: newIndex)
            }
            NotificationCenter.default.post(name: .init(UsersData.notificationName), object: nil)
        }
    }
}
