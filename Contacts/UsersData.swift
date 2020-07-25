import UIKit
import CryptoKit

// Stores user data and methods for processing them
struct UsersData {
    
    public static var users = [User(name: "Serhii", email: "serhii@gmail.com", isOnline: true),
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
    
    private static let names = ["Vyacheslav", "Gennady", "Georgy", "Gleb", "Grigory", "Daniil", "Denis", "Dmitry", "Yevgeny",
                                "Yegor", "Zakhar", "Ivan", "Ilya", "Innokenty", "Iosif", "Kirill", "Konstantin", "Lev",
                                "Leonid", "Maksim", "Matvey", "Mikhail", "Moisey", "Nikita", "Nikolay", "Oleg", "Pavel",
                                "Pyotr", "Roman", "Ruslan", "Svyatoslav", "Semyon", "Stanislav", "Stepan", "Timofey",
                                "Timur","Fedor", "Filipp", "Eduard", "Yuri", "Yakov", "Yan", "Yaroslav", "Aleksandra", "Alisa"]
    
    
    public static func changeData() {
        DispatchQueue.global().async {
            changeOnlineStatus()
            changeNamesAndEmails()
            addOrRemoveUsers()
            DispatchQueue.main.async {
                // Calls methods to update tableView and collectionView
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "collectionView"), object: nil)
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "tableView"), object: nil)
            }
        }
    }
    
    // Randomly changes the online status of each user
    private static func changeOnlineStatus() {
        for i in 0..<users.count {
            users[i].isOnline = Bool.random()
        }
    }
    
    // Randomly selects users and changes their names and email
    private static func changeNamesAndEmails() {
        let number = Int.random(in: 0..<users.count)
        
        for _ in 0..<number {
            let indexUsers = Int.random(in: 0..<users.count)
            let indexNames = Int.random(in: 0..<names.count)
            users[indexUsers].name = names[indexNames]
            users[indexUsers].email = "\(names[indexNames])@gmail.com"
        }
    }
    
    // Adds or removes a random number of users
    private static func addOrRemoveUsers() {
        let number = Int.random(in: 0..<users.count/2) 
        let remove = Bool.random()
        
        for _ in 0..<number {
            
            if remove {
                let indexUsers = Int.random(in: 0..<users.count)
                users.remove(at: indexUsers)
            } else {
                let index = Int.random(in: 0..<names.count)
                let name = names[index]
                let email = "\(name)@gmail.com"
                users.append(User(name: name, email: email, isOnline: Bool.random()))
            }
        }
    }
    
    // They will change the location of the user in the array after viewing additional information about him
    public static func replaceUser(oldIndex: Int, newIndex: Int) {
        DispatchQueue.global().async {
            let user = users.remove(at: oldIndex)
            users.insert(user, at: newIndex)
        }
    }
    
    // Shuffles an array of users after moving between collectionView and tableView
    public static func mixUsers() {
        DispatchQueue.global().async {
            for i in 0..<users.count {
                let user = users.remove(at: i)
                let newIndex = Int.random(in: 0..<users.count)
                users.insert(user, at: newIndex)
            }
        }
    }
    
    // Gets a user image
    public static func getImage(size: Int, user: User) -> UIImage? {
        guard let hash = getHash(email: user.email) else { return nil }
        guard let url = URL(string: "https://secure.gravatar.com/avatar/\(hash))?d=monsterid&s=\(size)") else { return nil }
        guard let data = try? Data(contentsOf: url) else { return nil }
        guard let image = UIImage(data: data) else { return nil }
        return image
    }
    
    // Gets the hash code needed to get the image
    private static func getHash(email: String) -> String? {
        guard let data = email.data(using: .utf8) else { return nil }
        let hash = Insecure.MD5.hash(data: data)
        return hash.map { String(format: "%02hhx", $0) }.joined()
    }
}
