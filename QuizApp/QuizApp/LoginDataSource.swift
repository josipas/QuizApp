import Foundation

protocol LoginDataSourceProtocol {

    func login(username: String, password: String) async -> LoginResponse?

}

class LoginDataSource: LoginDataSourceProtocol {

    private let loginClient = LoginClient()

    func login(username: String, password: String) async -> LoginResponse? {
        let result = await loginClient.login(username: username, password: password, path: "login")

        switch result {
        case .success(let accessToken):
            return accessToken
        default:
            return nil
        }
    }

}
