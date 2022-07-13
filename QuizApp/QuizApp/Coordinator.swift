import UIKit

class Coordinator: CoordinatorProtocol {

    private let appDependencies: AppDependencies
    private let navigationController: UINavigationController

    init(navigationController: UINavigationController, appDependencies: AppDependencies) {
        self.navigationController = navigationController
        self.appDependencies = appDependencies
    }

    func showLogIn() {
        let logInViewController = LoginViewController(
            viewModel: LoginViewModel(
                loginUseCase: appDependencies.loginUseCase,
                coordinator: self))

        navigationController.pushViewController(logInViewController, animated: true)
    }

    func showUserViewController() {
        let userViewController = UserViewController()

        navigationController.pushViewController(userViewController, animated: true)
    }

}
