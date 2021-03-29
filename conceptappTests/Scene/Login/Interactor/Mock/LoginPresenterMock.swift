import Foundation
@testable import conceptapp

class LoginPresenterMock: LoginPresentable {
    @Spy var invokeConfigure: Bool?
    @Spy var invokeRouteToHomeWithUser: User?
    @Spy var invokeErrorMessage: String?
    
    func configure() {
        self.invokeConfigure = true
    }
    
    func routeToHome(with user: User) {
        self.invokeRouteToHomeWithUser = user
    }
    
    func presentError(message: String) {
        self.invokeErrorMessage = message
    }
    
}
