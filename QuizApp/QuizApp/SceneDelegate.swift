import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    let appDependencies = AppDependencies()
    let navigationController = UINavigationController()

    var coordinator: Coordinator!
    var window: UIWindow?

    override init() {
        super.init()

        coordinator = Coordinator(navigationController: navigationController, appDependencies: appDependencies)
    }

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = scene as? UIWindowScene else { return }

        navigationController.setNavigationBarHidden(true, animated: false)

        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()

        Task(priority: .background) {
            do {
                try await appDependencies.tokenCheckClient.validateToken()

                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }

                    self.coordinator.showTabBarController()
                }
            } catch {
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }

                    self.coordinator.showLogIn()
                }
            }
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }

}
