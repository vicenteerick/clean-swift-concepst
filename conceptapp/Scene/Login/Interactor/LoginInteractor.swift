import Foundation

protocol LoginInteracting {
    func configure()
    func login(username: String?, password: String?)
}

final class LoginInteractor: LoginInteracting {
    private let presenter: LoginPresentable
    private let repository: LoginRepositoring
    
    init(presenter: LoginPresentable, repository: LoginRepositoring) {
        self.presenter = presenter
        self.repository = repository
    }
    
    func configure() {
        presenter.configure()
    }
    
    func login(username: String?, password: String?) {
        guard let username = username,
              let password = password else {
            self.presenter.presentError(message: "Username or password is wrong.")
            return
        }
        
        repository.login(username: username, password: password) { result in
            switch result {
            case let .success(user):
                self.presenter.routeToHome(with: user)
            case let .failure(error):
                self.presenter.presentError(message: error.description)
            }
        }
    }
    
}

