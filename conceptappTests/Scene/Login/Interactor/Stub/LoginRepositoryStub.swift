import Foundation
@testable import conceptapp

class LoginRepositoryStub: LoginRepositoring {
    var isSuccess: Bool = true
    private let failure: AuthError
    
    init(failure: AuthError) {
        self.failure = failure
    }
    
    func login(username: String, password: String, completion: (Result<User, AuthError>) -> Void) {
        if isSuccess {
            completion(.success(User(username: username, name: "User Name")))
        } else {
            completion(.failure(failure))
        }
    }
}
