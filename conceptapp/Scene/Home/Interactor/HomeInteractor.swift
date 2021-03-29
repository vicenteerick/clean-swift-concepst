import Foundation

protocol HomeInteracting {
    func configure()
}

final class HomeInteractor: HomeInteracting {
    private let presenter: HomePresentable
    private let user: User
    
    init(presenter: HomePresentable, user: User) {
        self.presenter = presenter
        self.user = user
    }
    
    func configure() {
        presenter.present(name: user.name)
    }
    
}
