import Foundation

protocol TokenCheckClientProtocol {

    func check(token: String) async throws -> Bool

}

class TokenCheckClient: TokenCheckClientProtocol {

    private let baseUrl: String

    init(baseUrl: String) {
        self.baseUrl = baseUrl
    }

    func check(token: String) async throws -> Bool {
        guard let url = URL(string: "\(baseUrl)/v1/check") else {
            throw RequestError.invalidUrl
        }

        var request = URLRequest(url: url)
        request.addValue(token, forHTTPHeaderField: "Authorization")

        guard let (_, response) = try? await URLSession.shared.data(for: request) else {
            throw RequestError.serverError
        }

        guard let response = response as? HTTPURLResponse else {
            throw RequestError.responseError
        }

        switch response.statusCode {
        case 200:
            return true
        default:
            return false
        }
    }

}
