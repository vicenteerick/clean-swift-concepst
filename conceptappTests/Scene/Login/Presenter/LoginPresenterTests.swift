import XCTest
@testable import conceptapp

class LoginPresenterTests: XCTestCase {

    let mock = LoginViewControllerMock()
    let stub = HomeSceneFactoryStub()
    var sut: LoginPresenter!
        
    override func setUp() {
        sut = LoginPresenter(factory: stub)
        sut.viewController = mock
    }

    func test_configure_presentsContent_ViewModel() throws {
        sut.configure()
        
        XCTAssertNotNil(mock.$invokePresentContentViewModel.value)
        XCTAssertEqual(mock.$invokePresentContentViewModel.count, 1)
    }
    
    func test_routeToHome_pushesViewController() throws {
        sut.routeToHome(with: User(username: "Username", name: "Name"))
        
        XCTAssertNotNil(mock.$invokePushViewController.value)
        XCTAssertEqual(mock.$invokePushViewController.count, 1)
    }
    
    func test_presentError_presentsErrorMessage() throws {
        sut.presentError(message: "Error")
        
        XCTAssertEqual(mock.$invokePresentErrorMessage.value, "Error")
        XCTAssertEqual(mock.$invokePresentErrorMessage.count, 1)
    }

}
