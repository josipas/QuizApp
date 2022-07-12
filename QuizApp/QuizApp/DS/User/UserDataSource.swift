protocol UserDataSourceProtocol {

    func saveAccessToken(accessToken: String)

    func getAccessToken() -> String

}

class UserDataSource: UserDataSourceProtocol {

    private let securityStorage: SecurityStorageProtocol

    init(securityStorage: SecurityStorageProtocol) {
        self.securityStorage = securityStorage
    }

    func saveAccessToken(accessToken: String) {
        securityStorage.saveAccessToken(accessToken: accessToken)
    }

    func getAccessToken() -> String {
        securityStorage.getAccessToken()
    }

}
