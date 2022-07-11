import Foundation

protocol LoginUseCaseProtocol {

    func login(username: String, password: String) async -> LoginResponse?

}

class LoginUseCase: LoginUseCaseProtocol {

    private let loginDataSource = LoginDataSource()

    func login(username: String, password: String) async -> LoginResponse? {
        await loginDataSource.login(username: username, password: password)
    }

}
