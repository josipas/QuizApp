import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = scene as? UIWindowScene else { return }

        let appDependencies = AppDependencies()
        let navigationController = UINavigationController()
        let coordinator = Coordinator(navigationController: navigationController, appDependencies: appDependencies)

        Task(priority: .background) {
            do {
                let isTokenValid = try await appDependencies.tokenCheckDataSource.isAccessTokenValid()

                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }

                    isTokenValid ? coordinator.showUserViewController() : coordinator.showLogIn()

                    self.window = UIWindow(windowScene: windowScene)
                    self.window?.rootViewController = navigationController
                    self.window?.makeKeyAndVisible()
                }
            } catch {
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
