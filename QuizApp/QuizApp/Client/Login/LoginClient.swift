import Foundation

protocol LoginClientProtocol {

    func login(username: String, password: String) async throws -> LoginResponseClientModel

}

private struct LoginRequest: Codable {

    let password: String
    let username: String

}

class LoginClient: LoginClientProtocol {

    private let path = "/v1/login"
    private let networkClient: NetworkClientProtocol

    init(networkClient: NetworkClientProtocol) {
        self.networkClient = networkClient
    }

    func login(username: String, password: String) async throws -> LoginResponseClientModel {
        try await networkClient.executeRequest(
            path: path,
            method: .post,
            header: ["Content-Type": "application/json"],
            body: LoginRequest(password: password, username: username))
    }

}
