import UIKit

protocol LoginSceneFactoring {
    func buildStructure() -> UIViewController
}

struct LoginSceneFactory: LoginSceneFactoring {
    
    func buildStructure() -> UIViewController {
        let presenter = LoginPresenter(factory: HomeSceneFactory())
        let interactor = LoginInteractor(presenter: presenter, repository: LoginRepository())
        let viewController = LoginViewController(interactor: interactor)
        
        presenter.viewController = viewController
        
        return UINavigationController(rootViewController: viewController)
    }
    
}
