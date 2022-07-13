protocol TokenCheckDataSourceProtocol {

    func isAccessTokenValid() async throws -> Bool

}

class TokenCheckDataSource: TokenCheckDataSourceProtocol {

    private let securityStorage: SecurityStorageProtocol
    private let tokenCheckClient: TokenCheckClientProtocol

    init(securityStorage: SecurityStorageProtocol, tokenCheckClient: TokenCheckClientProtocol) {
        self.securityStorage = securityStorage
        self.tokenCheckClient = tokenCheckClient
    }

    func isAccessTokenValid() async throws -> Bool {
        guard let accessToken = securityStorage.accessToken else { return false }

        return try await tokenCheckClient.check(token: accessToken)
    }

}
