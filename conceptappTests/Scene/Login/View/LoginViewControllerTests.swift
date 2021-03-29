import XCTest
@testable import conceptapp

class LoginViewControllerTests: XCTestCase {

    var mock = LoginInteractorMock()
    var sut: LoginViewController!
    
    override func setUp() {
        sut = LoginViewController(interactor: mock)
    }
    
    func test_viewDidLoad_callsConfigure() throws {
        _ = sut.view
        XCTAssertEqual(mock.$invokeConfigure.value, true)
        XCTAssertEqual(mock.$invokeConfigure.count, 1)
    }

}
