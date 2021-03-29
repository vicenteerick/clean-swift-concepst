import Foundation
@testable import conceptapp

class LoginInteractorMock: LoginInteracting {
    
    @Spy var invokeConfigure: Bool?
    
    func configure() {
        invokeConfigure = true
    }
    
    func login(username: String?, password: String?) { }
    
    
    
    
}
