protocol UserDataSourceProtocol {

    func saveAccessToken(accessToken: String)

    var accessToken: String? { get }

}

class UserDataSource: UserDataSourceProtocol {

    private let securityStorage: SecurityStorageProtocol

    var accessToken: String? {
        securityStorage.accessToken
    }

    init(securityStorage: SecurityStorageProtocol) {
        self.securityStorage = securityStorage
    }

    func saveAccessToken(accessToken: String) {
        securityStorage.saveAccessToken(accessToken: accessToken)
    }

}
