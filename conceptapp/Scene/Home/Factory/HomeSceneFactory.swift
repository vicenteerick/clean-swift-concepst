import UIKit

protocol HomeSceneFactoring {
    func buildStructure(user: User) -> UIViewController
}

struct HomeSceneFactory: HomeSceneFactoring {
    
    func buildStructure(user: User) -> UIViewController {
        let presenter = HomePresenter()
        let interactor = HomeInteractor(presenter: presenter, user: user)
        let viewController = HomeViewController(interactor: interactor)
        
        presenter.viewController = viewController
        
        return viewController
    }
    
}
