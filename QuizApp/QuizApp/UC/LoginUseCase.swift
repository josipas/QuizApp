import Foundation

protocol LoginUseCaseProtocol {

    func login(username: String, password: String) async throws -> LoginResponseModel

}

class LoginUseCase: LoginUseCaseProtocol {

    private let loginDataSource: LoginDataSourceProtocol

    init(loginDataSource: LoginDataSourceProtocol) {
        self.loginDataSource = loginDataSource
    }

    func login(username: String, password: String) async throws -> LoginResponseModel {
        let accessToken = try await loginDataSource.login(username: username, password: password).accessToken
        return LoginResponseModel(accessToken: accessToken)
    }

}
