import UIKit

protocol HomeDisplayable: AnyObject {
    func presentContent(description: String)
}

class HomeViewController: UIViewController {

    lazy var homeDescription: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        return label
    }()
    
    let interactor: HomeInteracting
    
    init(interactor: HomeInteracting) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureViewStructure()
        interactor.configure()
    }
    
    private func configureViewStructure() {
        buildViewHierarchy()
        configureConstraintLayout()
    }
    
    private func buildViewHierarchy() {
        view.backgroundColor = .white
        view.addSubview(homeDescription)
    }
    
    private func configureConstraintLayout() {
        homeDescription.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        homeDescription.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
}

extension HomeViewController: HomeDisplayable {
    
    func presentContent(description: String) {
        homeDescription.text = description
    }
    
}
