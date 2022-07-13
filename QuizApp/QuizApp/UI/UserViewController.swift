import UIKit

class UserViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        styleViews()
    }

}

extension UserViewController: ConstructViewsProtocol {

    func createViews() {
    }

    func styleViews() {
        view.backgroundColor = .blue

        navigationController?.isNavigationBarHidden = false
    }

    func defineLayoutForViews() {
    }

}
