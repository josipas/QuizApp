protocol UserDataSourceProtocol {

    func save(accessToken: String)

    var accessToken: String? { get }

    func clearAccessToken() throws

    var data: AccountResponseDataModel { get async throws }

    func updateData(name: String) async throws -> AccountResponseDataModel

}

class UserDataSource: UserDataSourceProtocol {

    private let securityStorage: SecurityStorageProtocol
    private let accountClient: AccountClientProtocol

    var accessToken: String? {
        securityStorage.accessToken
    }

    var data: AccountResponseDataModel {
        get async throws {
            AccountResponseDataModel(from: try await accountClient.data)
        }
    }

    init(securityStorage: SecurityStorageProtocol, accountClient: AccountClientProtocol) {
        self.securityStorage = securityStorage
        self.accountClient = accountClient
    }

    func save(accessToken: String) {
        securityStorage.save(accessToken: accessToken)
    }

    func clearAccessToken() throws {
        try securityStorage.clearAccessToken()
    }

    func updateData(name: String) async throws -> AccountResponseDataModel {
        AccountResponseDataModel(from: try await accountClient.updateData(name: name))
    }

}
