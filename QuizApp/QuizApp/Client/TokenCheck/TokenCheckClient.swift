import Foundation

protocol TokenCheckClientProtocol {

    func validateToken() async throws

}

class TokenCheckClient: TokenCheckClientProtocol {

    private let path = "/v1/check"
    private let securityStorage: SecurityStorageProtocol
    private let networkClient: NetworkClientProtocol

    init(securityStorage: SecurityStorageProtocol, networkClient: NetworkClientProtocol) {
        self.securityStorage = securityStorage
        self.networkClient = networkClient
    }

    func validateToken() async throws {
        guard let token = securityStorage.accessToken else {
            throw RequestError.invalidToken
        }

        try await networkClient.executeRequest(path: path, header: ["Authorization": "Bearer \(token)"])
    }

}
