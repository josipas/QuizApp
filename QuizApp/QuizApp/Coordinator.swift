import UIKit
import Factory

class Coordinator: CoordinatorProtocol {

    private let navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func showLogIn() {
        navigationController.setViewControllers([Container.loginViewController()], animated: true)
    }

    func showTabBarController() {
        navigationController.setViewControllers([setUpTabBarController()], animated: true)
    }

    private func setUpTabBarController() -> UITabBarController {
        let tabBarController = UITabBarController()

        tabBarController.tabBar.backgroundColor = .white
        tabBarController.tabBar.tintColor = UIColor(red: 0.387, green: 0.16, blue: 0.871, alpha: 1)

        tabBarController.viewControllers = [
            makeQuizViewController(),
            makeUserViewController()]

        return tabBarController
    }

    private func makeQuizViewController() -> UIViewController {
        let quizViewController = Container.quizViewController()

        quizViewController.tabBarItem = UITabBarItem(
            title: "Quiz",
            image: UIImage(named: "Quiz"),
            tag: 0)

        return quizViewController
    }

    private func makeUserViewController() -> UIViewController {
        let userViewController = Container.userViewController()

        userViewController.tabBarItem = UITabBarItem(
            title: "Settings",
            image: UIImage(named: "Settings"),
            tag: 1)

        return userViewController
    }

}
