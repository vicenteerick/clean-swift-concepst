import UIKit
@testable import conceptapp

struct HomeSceneFactoryStub: HomeSceneFactoring {
    
    func buildStructure(user: User) -> UIViewController {
        return UIViewController()
    }
    
}
