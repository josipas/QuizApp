import KeychainAccess

protocol SecurityStorageProtocol {

    func saveAccessToken(accessToken: String)

    var accessToken: String? { get }

}

class SecurityStorage: SecurityStorageProtocol {

    private let keychain: Keychain
    private let accessTokenKey = "accessToken"

    var accessToken: String? {
        keychain[accessTokenKey]
    }

    init() {
        self.keychain = Keychain(service: "five.agency.josipasupe.QuizApp")
    }

    func saveAccessToken(accessToken: String) {
        keychain[accessTokenKey] = accessToken
    }

}
