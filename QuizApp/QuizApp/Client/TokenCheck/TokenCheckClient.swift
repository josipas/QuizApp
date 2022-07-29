import Foundation

protocol TokenCheckClientProtocol {

    func validateToken() async throws

}

class TokenCheckClient: TokenCheckClientProtocol {

    private let path = "/v1/check"
    private let networkClient: NetworkClientProtocol

    init(networkClient: NetworkClientProtocol) {
        self.networkClient = networkClient
    }

    func validateToken() async throws {
        try await networkClient.executeRequest(path: path)
    }

}
