import KeychainAccess

protocol SecurityStorageProtocol {

    func save(accessToken: String)

    var accessToken: String? { get }

    func clearAccessToken() throws

}

class SecurityStorage: SecurityStorageProtocol {

    private let keychain = Keychain(service: "five.agency.josipasupe.QuizApp")
    private let accessTokenKey = "accessToken"

    var accessToken: String? {
        keychain[accessTokenKey]
    }

    func save(accessToken: String) {
        keychain[accessTokenKey] = accessToken
    }

    func clearAccessToken() throws {
        try keychain.remove(accessTokenKey)
    }

}
