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
    private let securityStorage: SecurityStorageProtocol
    private let networkClient: NetworkClientProtocol

    var data: AccountResponseClientModel {
        get async throws {
            guard let token = securityStorage.accessToken else {
                throw RequestError.invalidToken
            }

            return try await networkClient.executeRequest(
                path: path,
                method: .get,
                header: ["Authorization": "Bearer \(token)"])
        }
    }

    init(securityStorage: SecurityStorageProtocol, networkClient: NetworkClientProtocol) {
        self.securityStorage = securityStorage
        self.networkClient = networkClient
    }

    func updateData(name: String) async throws -> AccountResponseClientModel {
        guard let token = securityStorage.accessToken else {
            throw RequestError.invalidToken
        }

        return try await networkClient.executeRequest(
                path: path,
                method: .patch,
                header: ["Content-Type": "application/json",
                         "Authorization": "Bearer \(token)"],
                body: AccountRequestClientModel(name: name))
    }

}
