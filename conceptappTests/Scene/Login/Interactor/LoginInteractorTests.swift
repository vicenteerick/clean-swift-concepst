import XCTest
@testable import conceptapp

class LoginInteractorTests: XCTestCase {
    
    var mock: LoginPresenterMock!
    var stub: LoginRepositoryStub!
    var sut: LoginInteracting!
    
    override func setUp() {
        mock = LoginPresenterMock()
        stub = LoginRepositoryStub(failure: .notAllowed)
        sut = LoginInteractor(presenter: mock, repository: stub)
    }

    func test_configure_configurePresenter() {
        sut.configure()
        XCTAssertEqual(mock.$invokeConfigure.value, true)
        XCTAssertEqual(mock.$invokeConfigure.count, 1)
    }

    func test_login_whenSuccess_routeToHome_withUser() {
        sut.login(username: "user.name", password: "1234")
        XCTAssertEqual(mock.$invokeRouteToHomeWithUser.value?.username, "user.name")
        XCTAssertEqual(mock.$invokeRouteToHomeWithUser.count, 1)
    }
    
    func test_login_whenFailure_presenteErrorMessage() {
        stub.isSuccess = false
        sut.login(username: "", password: "")
        XCTAssertEqual(mock.$invokeErrorMessage.value?.description, "User not allowed")
        XCTAssertEqual(mock.$invokeErrorMessage.count, 1)
    }
    
    func test_login_whenHasNoUsername_presenteErrorMessage() {
        stub.isSuccess = false
        sut.login(username: nil, password: "123")
        XCTAssertEqual(mock.$invokeErrorMessage.value?.description, "Username or password is wrong.")
        XCTAssertEqual(mock.$invokeErrorMessage.count, 1)
    }
    
    func test_login_whenHasNoPassword_presenteErrorMessage() {
        stub.isSuccess = false
        sut.login(username: "user.name", password: nil)
        XCTAssertEqual(mock.$invokeErrorMessage.value?.description, "Username or password is wrong.")
        XCTAssertEqual(mock.$invokeErrorMessage.count, 1)
    }
    
    func test_login_whenHasNoUsername_andNoPassword_presenteErrorMessage() {
        stub.isSuccess = false
        sut.login(username: nil, password: nil)
        XCTAssertEqual(mock.$invokeErrorMessage.value?.description, "Username or password is wrong.")
        XCTAssertEqual(mock.$invokeErrorMessage.count, 1)
    }
    
}
