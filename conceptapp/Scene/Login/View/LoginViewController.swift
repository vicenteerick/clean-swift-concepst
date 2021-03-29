import UIKit

protocol LoginDisplayable: AnyObject {
    func presentContent(viewModel: ContentViewModel)
    func push(viewController: UIViewController)
    func presentError(message: String)
}

class LoginViewController: UIViewController {

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var emailTitle: UILabel = UILabel()
    private lazy var emailTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.autocapitalizationType = .none
        return textField
    }()
    
    private lazy var passwordTitle: UILabel = UILabel()
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.autocapitalizationType = .none
        textField.isSecureTextEntry = true
        return textField
    }()
    
    private lazy var buttonContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .black
        button.tintColor = .white
        button.addTarget(self, action: #selector(login), for: .touchUpInside)
        return button
    }()
    
    private lazy var containerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [emailTitle, emailTextField, passwordTitle, passwordTextField, buttonContainerView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.setCustomSpacing(16.0, after: emailTextField)
        stackView.setCustomSpacing(24.0, after: passwordTextField)
        stackView.spacing = 8.0
        stackView.axis = .vertical
        return stackView
    }()
    
    private let interactor: LoginInteracting
    
    init(interactor: LoginInteracting) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewStructure()
        initializeHideKeyboard()
        subscribeKeyboard()
        interactor.configure()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromAllNotifications()
    }
    
    private func subscribeKeyboard() {
        subscribeToNotification(UIResponder.keyboardWillShowNotification, selector: #selector(keyboardWillShowOrHide))
        subscribeToNotification(UIResponder.keyboardWillHideNotification, selector: #selector(keyboardWillShowOrHide))
    }
    
    private func configureViewStructure() {
        buildViewHierarchy()
        configureConstraintLayout()
    }
    
    private func buildViewHierarchy() {
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(containerStackView)
        buttonContainerView.addSubview(loginButton)
    }
    
    private func configureConstraintLayout() {
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        containerStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 100.0).isActive = true
        containerStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16.0).isActive = true
        containerStackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        
        loginButton.topAnchor.constraint(equalTo: buttonContainerView.topAnchor).isActive = true
        loginButton.bottomAnchor.constraint(equalTo: buttonContainerView.bottomAnchor).isActive = true
        loginButton.leadingAnchor.constraint(equalTo: buttonContainerView.leadingAnchor).isActive = true
        loginButton.trailingAnchor.constraint(equalTo: buttonContainerView.trailingAnchor).isActive = true
        
        loginButton.heightAnchor.constraint(equalToConstant: 40.0).isActive = true
        loginButton.widthAnchor.constraint(equalTo: buttonContainerView.widthAnchor).isActive = true
    }
    
    @objc private func login() {
        interactor.login(username: emailTextField.text, password: passwordTextField.text)
    }

}

extension LoginViewController: LoginDisplayable {
    
    func presentContent(viewModel: ContentViewModel) {
        emailTitle.text = viewModel.emailText
        emailTextField.placeholder = viewModel.emailPlaceholder
        
        passwordTitle.text = viewModel.passwordText
        passwordTextField.placeholder = viewModel.passwordPlaceholder
        
        loginButton.setTitle(viewModel.buttonTitle, for: .normal)
    }
    
    func push(viewController: UIViewController) {
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func presentError(message: String) {
        let alertController = UIAlertController(title: "VIP", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        
        present(alertController, animated: true, completion: nil)
    }
}

private extension LoginViewController {
    
    func initializeHideKeyboard(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissMyKeyboard))
        
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissMyKeyboard(){
        view.endEditing(true)
    }
    
    func subscribeToNotification(_ notification: NSNotification.Name, selector: Selector) {
        NotificationCenter.default.addObserver(self, selector: selector, name: notification, object: nil)
    }
    
    func unsubscribeFromAllNotifications() {
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func keyboardWillShowOrHide(notification: NSNotification) {
        
        if let userInfo = notification.userInfo,
           let endValue = userInfo[UIResponder.keyboardFrameEndUserInfoKey],
           let durationValue = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey],
           let curveValue = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] {
            
            
            let endRect = view.convert((endValue as AnyObject).cgRectValue, from: view.window)
            let keyboardOverlap = scrollView.frame.maxY - endRect.origin.y
            
            scrollView.contentInset.bottom = keyboardOverlap
            scrollView.verticalScrollIndicatorInsets.bottom = keyboardOverlap
            
            let duration = (durationValue as AnyObject).doubleValue
            let options = UIView.AnimationOptions(rawValue: UInt((curveValue as AnyObject).integerValue << 16))
            UIView.animate(withDuration: duration!, delay: 0, options: options, animations: {
                self.view.layoutIfNeeded()
            }, completion: nil)
        }
    }

}
