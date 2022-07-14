import UIKit

class Coordinator: CoordinatorProtocol {

    private let appDependencies: AppDependencies
    private let navigationController: UINavigationController

    init(navigationController: UINavigationController, appDependencies: AppDependencies) {
        self.navigationController = navigationController
        self.appDependencies = appDependencies
    }

    func showLogIn() {
        let logInViewController = createLoginViewController()

        navigationController.pushViewController(logInViewController, animated: true)
    }

    func showUserViewController() {
        navigationController.pushViewController(setUpTabBar(), animated: true)
    }

    func logOut() {
        navigationController.setViewControllers([createLoginViewController()], animated: true)
    }

    private func createLoginViewController() -> UIViewController {
        LoginViewController(
            viewModel: LoginViewModel(
                loginUseCase: appDependencies.loginUseCase,
                coordinator: self))
    }

    private func setUpTabBar() -> UITabBarController {
        let tabBarController = UITabBarController()

        tabBarController.tabBar.backgroundColor = .white
        tabBarController.tabBar.tintColor = UIColor(red: 0.387, green: 0.16, blue: 0.871, alpha: 1)

        tabBarController.viewControllers =  [
            createQuizViewController(),
            createUserViewController()]

        return tabBarController
    }

    private func createQuizViewController() -> UINavigationController {
        let quizViewController = QuizViewController()
        let quizNavigationController = UINavigationController(rootViewController: quizViewController)

        quizNavigationController.tabBarItem = UITabBarItem(
            title: "Quiz",
            image: UIImage(named: "Quiz"),
            tag: 0)

        return quizNavigationController
    }

    private func createUserViewController() -> UINavigationController {
        let userViewController = UserViewController(
            viewModel: UserViewModel(
                coordinator: self,
                userUseCase: appDependencies.userUseCase))
        let userNavigationController = UINavigationController(rootViewController: userViewController)

        userNavigationController.tabBarItem = UITabBarItem(
            title: "Settings",
            image: UIImage(named: "Settings"),
            tag: 1)

        return userNavigationController
    }

}
