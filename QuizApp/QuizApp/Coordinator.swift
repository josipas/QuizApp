import UIKit

class Coordinator: CoordinatorProtocol {

    private let appDependencies = AppDependencies()
    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func showLogIn() {
        let logInViewController = LoginViewController(
            viewModel: LoginViewModel(
                loginUseCase: appDependencies.loginUseCase
            )
        )

        navigationController.pushViewController(logInViewController, animated: true)
    }

}
