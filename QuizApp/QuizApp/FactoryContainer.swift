import UIKit
import Factory

// MARK: Util
extension Container {

    static let baseUrl = Factory(scope: .singleton) {
        "https://five-ios-quiz-app.herokuapp.com/api"
    }

    static let navigationController = Factory(scope: .singleton) {
        UINavigationController()
    }

    static let coordinator = Factory(scope: .singleton) {
        Coordinator(navigationController: navigationController()) as CoordinatorProtocol
    }

    static let securityStorage = Factory(scope: .singleton) {
        SecurityStorage() as SecurityStorageProtocol
    }

}

// MARK: Client
extension Container {

    static let networkClient = Factory(scope: .singleton) {
        NetworkClient(baseUrl: baseUrl(), securityStorage: securityStorage()) as NetworkClientProtocol
    }

    static let accountClient = Factory(scope: .singleton) {
        AccountClient(networkClient: networkClient()) as AccountClientProtocol
    }

    static let tokenCheckClient = Factory(scope: .singleton) {
        TokenCheckClient(networkClient: networkClient()) as TokenCheckClientProtocol
    }

    static let loginClient = Factory(scope: .singleton) {
        LoginClient(networkClient: networkClient()) as LoginClientProtocol
    }

    static let quizClient = Factory(scope: .singleton) {
        QuizClient(networkClient: networkClient()) as QuizClientProtocol
    }

}

// MARK: DS
extension Container {

    static let loginDataSource = Factory(scope: .singleton) {
        LoginDataSource(loginClient: loginClient()) as LoginDataSourceProtocol
    }

    static let userDataSource = Factory(scope: .singleton) {
        UserDataSource(securityStorage: securityStorage(), accountClient: accountClient()) as UserDataSourceProtocol
    }

    static let quizDataSource = Factory(scope: .singleton) {
        QuizDataSource(quizClient: quizClient()) as QuizDataSourceProtocol
    }

}

// MARK: UC
extension Container {

    static let loginUseCase = Factory(scope: .singleton) {
        LoginUseCase(loginDataSource: loginDataSource(), userDataSource: userDataSource()) as LoginUseCaseProtocol
    }

    static let userUseCase = Factory(scope: .singleton) {
        UserUseCase(userDataSource: userDataSource()) as UserUseCaseProtocol
    }

    static let quizUseCase = Factory(scope: .singleton) {
        QuizUseCase(quizDataSource: quizDataSource()) as QuizUseCaseProtocol
    }

}

// MARK: VM
extension Container {

    static let loginViewModel = Factory {
        LoginViewModel(loginUseCase: loginUseCase(), coordinator: coordinator())
    }

    static let userViewModel = Factory {
        UserViewModel(coordinator: coordinator(), userUseCase: userUseCase())
    }

    static let quizViewModel = Factory {
        QuizViewModel(coordinator: coordinator(), quizUseCase: quizUseCase())
    }

}

// MARK: VC
extension Container {

    static let loginViewController = Factory {
        LoginViewController(viewModel: loginViewModel())
    }

    static let userViewController = Factory {
        UserViewController(viewModel: userViewModel())
    }

    static let quizViewController = Factory {
        QuizViewController(viewModel: quizViewModel())
    }

}
