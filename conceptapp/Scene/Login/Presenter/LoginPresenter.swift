import UIKit

protocol LoginPresentable {
    func configure()
    func routeToHome(with user: User)
    func presentError(message: String)
}

final class LoginPresenter: LoginPresentable {
    weak var viewController: LoginDisplayable?
    private let factory: HomeSceneFactoring
    
    init(factory: HomeSceneFactoring) {
        self.factory = factory
    }
    
    func configure() {
        viewController?.presentContent(viewModel: ContentViewModel())
    }
    
    func routeToHome(with user: User) {
        viewController?.push(viewController: factory.buildStructure(user: user))
    }
    
    func presentError(message: String) {
        viewController?.presentError(message: message)
    }
}
