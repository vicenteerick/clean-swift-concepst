import UIKit

protocol HomePresentable {
    func present(name: String)
}

final class HomePresenter: HomePresentable {
    weak var viewController: HomeDisplayable?
    
    func present(name: String) {
        viewController?.presentContent(description: "Bem vindo, \(name)")
    }
    
}
