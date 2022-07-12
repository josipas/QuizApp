import Foundation

protocol LoginClientProtocol {

    func login(username: String, password: String) async throws -> LoginResponseClientModel

}

private struct LoginRequest: Codable {

    let password: String
    let username: String

}

class LoginClient: LoginClientProtocol {

    private let baseUrl: String

    init(baseUrl: String) {
        self.baseUrl = baseUrl
    }

    func login(username: String, password: String) async throws -> LoginResponseClientModel {
        guard let url = URL(string: "\(baseUrl)/v1/login") else {
            throw RequestError.invalidUrl
        }

        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = try? JSONEncoder().encode(LoginRequest(password: password, username: username))

        guard let (data, response) = try? await URLSession.shared.data(for: request) else {
            throw RequestError.serverError
        }

        guard let response = response as? HTTPURLResponse else {
            throw RequestError.responseError
        }

        guard (200...299).contains(response.statusCode) else {
            switch response.statusCode {
            case 400:
                throw RequestError.badRequest
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

        guard let value = try? JSONDecoder().decode(LoginResponseClientModel.self, from: data) else {
            throw RequestError.dataDecodingError
        }

        return value
    }

}
