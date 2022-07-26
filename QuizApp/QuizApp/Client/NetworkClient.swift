import Foundation

protocol NetworkClientProtocol {

    func executeRequest(path: String) async throws

    func executeRequest<T: Decodable, E: Encodable>(
        path: String,
        method: RequestMethod,
        header: [String: String]?,
        body: E
    ) async throws -> T

    func executeRequest<T: Decodable, E: Encodable>(path: String, method: RequestMethod, body: E) async throws -> T

    func executeRequest<T: Decodable>(path: String, method: RequestMethod) async throws -> T

}

class NetworkClient: NetworkClientProtocol {

    private let baseUrl: String
    private let securityStorage: SecurityStorageProtocol

    private var token: String {
        securityStorage.accessToken ?? ""
    }

    init(baseUrl: String, securityStorage: SecurityStorageProtocol) {
        self.baseUrl = baseUrl
        self.securityStorage = securityStorage
    }

    func executeRequest(path: String) async throws {
        let header = ["Authorization": "Bearer \(token)"]

        let request = try await createRequest(path: path, method: .get, header: header)

        guard let (_, response) = try? await URLSession.shared.data(for: request) else {
            throw RequestError.serverError
        }

        try handleErrors(response: response)
    }

    func executeRequest<T: Decodable, E: Encodable>(
        path: String,
        method: RequestMethod,
        header: [String: String]?,
        body: E
    ) async throws -> T {
        let request = try await createRequest(path: path, method: method, header: header, body: body)

        guard let (data, response) = try? await URLSession.shared.data(for: request) else {
            throw RequestError.serverError
        }

        try handleErrors(response: response)

        guard let value = try? JSONDecoder().decode(T.self, from: data) else {
            throw RequestError.dataDecodingError
        }

        return value
    }

    func executeRequest<T: Decodable, E: Encodable>(path: String, method: RequestMethod, body: E) async throws -> T {
        let header = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(token)"]

        let request = try await createRequest(path: path, method: method, header: header, body: body)

        guard let (data, response) = try? await URLSession.shared.data(for: request) else {
            throw RequestError.serverError
        }

        try handleErrors(response: response)

        guard let value = try? JSONDecoder().decode(T.self, from: data) else {
            throw RequestError.dataDecodingError
        }

        return value
    }

    func executeRequest<T: Decodable>(path: String, method: RequestMethod) async throws -> T {
        let header = ["Authorization": "Bearer \(token)"]

        let request = try await createRequest(path: path, method: method, header: header)

        guard let (data, response) = try? await URLSession.shared.data(for: request) else {
            throw RequestError.serverError
        }

        try handleErrors(response: response)

        guard let value = try? JSONDecoder().decode(T.self, from: data) else {
            throw RequestError.dataDecodingError
        }

        return value
    }

    private func createRequest<E: Encodable>(
        path: String,
        method: RequestMethod,
        header: [String: String]?,
        body: E
    ) async throws -> URLRequest {
        guard let url = URL(string: "\(baseUrl)\(path)") else {
            throw RequestError.invalidUrl
        }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = header

        switch method {
        case .patch, .post, .put:
            request.httpBody = try? JSONEncoder().encode(body)
        default:
            ()
        }

        return request
    }

    private func createRequest(
        path: String,
        method: RequestMethod,
        header: [String: String]?
    ) async throws -> URLRequest {
        guard let url = URL(string: "\(baseUrl)\(path)") else {
            throw RequestError.invalidUrl
        }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = header

        return request
    }

    private func handleErrors(response: URLResponse) throws {
        guard let response = response as? HTTPURLResponse else {
            throw RequestError.responseError
        }

        guard (200...203).contains(response.statusCode) else {
            switch response.statusCode {
            case 204:
                throw RequestError.noContent
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
    }

}
