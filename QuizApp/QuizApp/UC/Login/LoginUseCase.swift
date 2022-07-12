import Foundation

protocol LoginUseCaseProtocol {

    func login(username: String, password: String) async throws

}

class LoginUseCase: LoginUseCaseProtocol {

    private let loginDataSource: LoginDataSourceProtocol
    private let userDataSource: UserDataSourceProtocol

    init(loginDataSource: LoginDataSourceProtocol, userDataSource: UserDataSourceProtocol) {
        self.loginDataSource = loginDataSource
        self.userDataSource = userDataSource
    }

    func login(username: String, password: String) async throws {
        let accessToken = try await loginDataSource.login(username: username, password: password).accessToken
        userDataSource.saveAccessToken(accessToken: accessToken)
    }

}
