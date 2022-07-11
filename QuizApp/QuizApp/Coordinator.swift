import UIKit

class Coordinator: CoordinatorProtocol {

    private let navigationController: UINavigationController!

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func showLogIn() {
        let logInViewController = LoginViewController(viewModel: LoginViewModel())

        navigationController.pushViewController(logInViewController, animated: true)
    }

}
