import Foundation

protocol TokenCheckClientProtocol {

    func validateToken() async throws

}

class TokenCheckClient: TokenCheckClientProtocol {

    private let baseUrl: String
    private let securityStorage: SecurityStorageProtocol

    init(baseUrl: String, securityStorage: SecurityStorageProtocol) {
        self.baseUrl = baseUrl
        self.securityStorage = securityStorage
    }

    func validateToken() async throws {
        guard let token = securityStorage.accessToken else {
            throw RequestError.invalidToken
        }

        guard let url = URL(string: "\(baseUrl)/v1/check") else {
            throw RequestError.invalidUrl
        }

        var request = URLRequest(url: url)
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        guard let (_, response) = try? await URLSession.shared.data(for: request) else {
            throw RequestError.serverError
        }

        guard let response = response as? HTTPURLResponse else {
            throw RequestError.responseError
        }

        switch response.statusCode {
        case 200:
            return
        case 401:
            throw RequestError.unauthorized
        case 403:
            throw RequestError.forbidden
        case 404:
            throw RequestError.notFound
        default:
            throw RequestError.invalidToken
        }
    }

}
