protocol UserDataSourceProtocol {

    func save(accessToken: String)

    var accessToken: String? { get }

    func clearAccessToken() throws

    func getData() async throws -> AccountResponseDataModel

    func updateData(name: String) async throws

}

class UserDataSource: UserDataSourceProtocol {

    private let securityStorage: SecurityStorageProtocol
    private let accountClient: AccountClientProtocol

    var accessToken: String? {
        securityStorage.accessToken
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

    func getData() async throws -> AccountResponseDataModel {
        let accountModel = try await accountClient.getData()
        return AccountResponseDataModel(from: accountModel)
    }

    func updateData(name: String) async throws {
        try await accountClient.updateData(name: name)
    }

}
