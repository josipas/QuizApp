import Foundation

protocol LoginDataSourceProtocol {

    func login(username: String, password: String) async throws -> LoginResponseDataModel

}

class LoginDataSource: LoginDataSourceProtocol {

    private let loginClient: LoginClientProtocol

    init(loginClient: LoginClientProtocol) {
        self.loginClient = loginClient
    }

    func login(username: String, password: String) async throws -> LoginResponseDataModel {
        let accessToken = try await loginClient
            .login(username: username, password: password)
            .accessToken

        return LoginResponseDataModel(accessToken: accessToken)
    }

}
