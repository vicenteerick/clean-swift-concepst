import UIKit
@testable import conceptapp

class LoginViewControllerMock: LoginDisplayable {
    @Spy var invokePresentContentViewModel: ContentViewModel?
    @Spy var invokePushViewController: UIViewController?
    @Spy var invokePresentErrorMessage: String?
    
    
    func presentContent(viewModel: ContentViewModel) {
        invokePresentContentViewModel = viewModel
    }
    
    func push(viewController: UIViewController) {
        invokePushViewController = viewController
    }
    
    func presentError(message: String) {
        invokePresentErrorMessage = message
    }
    
}
