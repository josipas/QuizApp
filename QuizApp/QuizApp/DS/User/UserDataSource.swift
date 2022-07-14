protocol UserDataSourceProtocol {

    func save(accessToken: String)

    var accessToken: String? { get }

    func clear()

}

class UserDataSource: UserDataSourceProtocol {

    private let securityStorage: SecurityStorageProtocol

    var accessToken: String? {
        securityStorage.accessToken
    }

    init(securityStorage: SecurityStorageProtocol) {
        self.securityStorage = securityStorage
    }

    func save(accessToken: String) {
        securityStorage.save(accessToken: accessToken)
    }

    func clear() {
        securityStorage.clear()
    }

}
