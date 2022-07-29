import Foundation

protocol AccountClientProtocol {

    var data: AccountResponseClientModel { get async throws }

    func updateData(name: String) async throws -> AccountResponseClientModel

}

private struct AccountRequestClientModel: Codable {

    let name: String

}

class AccountClient: AccountClientProtocol {

    private let path = "/v1/account"
    private let networkClient: NetworkClientProtocol

    var data: AccountResponseClientModel {
        get async throws {
            try await networkClient.executeRequest(path: path, method: .get, parameters: nil)
        }
    }

    init(networkClient: NetworkClientProtocol) {
        self.networkClient = networkClient
    }

    func updateData(name: String) async throws -> AccountResponseClientModel {
        try await networkClient.executeRequest(
                path: path,
                method: .patch,
                body: AccountRequestClientModel(name: name))
    }

}
