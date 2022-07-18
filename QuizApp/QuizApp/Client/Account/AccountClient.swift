import Foundation

protocol AccountClientProtocol {

    func getData() async throws -> AccountResponseClientModel

    func updateData(name: String) async throws

}

private struct AccountRequestClientModel: Codable {

    let name: String

}

class AccountClient: AccountClientProtocol {

    private let baseUrl: String
    private let securityStorage: SecurityStorageProtocol

    init(baseUrl: String, securityStorage: SecurityStorageProtocol) {
        self.baseUrl = baseUrl
        self.securityStorage = securityStorage
    }

    func getData() async throws -> AccountResponseClientModel {
        guard let token = securityStorage.accessToken else {
            throw RequestError.invalidToken
        }

        guard let url = URL(string: "\(baseUrl)/v1/account") else {
            throw RequestError.invalidUrl
        }

        var request = URLRequest(url: url)
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        guard let (data, response) = try? await URLSession.shared.data(for: request) else {
            throw RequestError.serverError
        }

        guard let response = response as? HTTPURLResponse else {
            throw RequestError.responseError
        }

        guard (200...299).contains(response.statusCode) else {
            switch response.statusCode {
            case 401:
                throw RequestError.unauthorized
            case 403:
                throw RequestError.forbidden
            case 404:
                throw RequestError.notFound
            default:
                throw RequestError.unknownError
            }
        }

        guard let value = try? JSONDecoder().decode(AccountResponseClientModel.self, from: data) else {
            throw RequestError.dataDecodingError
        }

        return value
    }

    func updateData(name: String) async throws {
        guard let token = securityStorage.accessToken else {
            throw RequestError.invalidToken
        }

        guard let url = URL(string: "\(baseUrl)/v1/account") else {
            throw RequestError.invalidUrl
        }

        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpBody = try? JSONEncoder().encode(AccountRequestClientModel(name: name))

        guard let (_, response) = try? await URLSession.shared.data(for: request) else {
            throw RequestError.serverError
        }

        guard let response = response as? HTTPURLResponse else {
            throw RequestError.responseError
        }

        switch response.statusCode {
        case 200:
            return
        case 204:
            throw RequestError.noContent
        case 401:
            throw RequestError.unauthorized
        case 403:
            throw RequestError.forbidden
        default:
            throw RequestError.unknownError
        }
    }

}
