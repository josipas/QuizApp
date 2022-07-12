import KeychainAccess

protocol SecurityStorageProtocol {

    func saveAccessToken(accessToken: String)

    func getAccessToken() -> String

}

class SecurityStorage: SecurityStorageProtocol {

    private let keychain: Keychain

    init() {
        self.keychain = Keychain(service: "five.agency.josipasupe.QuizApp")
    }

    func saveAccessToken(accessToken: String) {
        keychain["accessToken"] = accessToken

//      za potrebe testiranja:
        print(getAccessToken())
    }

    func getAccessToken() -> String {
        keychain["accessToken"] ?? ""
    }

}
