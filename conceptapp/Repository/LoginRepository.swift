import Foundation

enum AuthError: Error, Equatable {
    case notAllowed
    case userNotFound
    case unowned
    
    var description: String {
        switch self {
        case .notAllowed:
            return "User not allowed"
        case .userNotFound:
            return "User not found"
        default:
            return "Please try again"
        }
    }
}

protocol LoginRepositoring {
    func login(username: String, password: String, completion: (Result<User, AuthError>) -> Void)
}

final class LoginRepository: LoginRepositoring {
    private let usersAuth: [String: String] = ["user.one": "12345", "user.two": "123456"]
    private let users: [User] = [User(username: "user.one", name: "User One"), User(username: "user.two", name: "User Two")]
    
    func login(username: String, password: String, completion: (Result<User, AuthError>) -> Void) {
        guard let user = users.first(where: { $0.username == username }) else {
            completion(.failure(.userNotFound))
            return
        }
        
        guard password == usersAuth[user.username] else {
            completion(.failure(.notAllowed))
            return
        }
        
        completion(.success(user))
    }
    
}
