import Foundation

protocol LoginClientProtocol {

    func login(username: String, password: String, path: String) async -> Result<LoginResponse, RequestError>

}

class LoginClient: LoginClientProtocol {

    private let baseUrl = "https://five-ios-quiz-app.herokuapp.com/api/v1/"

    func login(username: String, password: String, path: String) async -> Result<LoginResponse, RequestError> {
        guard let url = URL(string: "\(baseUrl)\(path)") else {
            return .failure(.invalidUrl)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = try? JSONEncoder().encode(Login(password: password, username: username))
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        do {
            let (data, response) = try await URLSession.shared.data(for: request, delegate: nil)

            guard
                let response = response as? HTTPURLResponse,
                (200...299).contains(response.statusCode)
            else {
                return .failure(.serverError)
            }

            guard let value = try? JSONDecoder().decode(LoginResponse.self, from: data) else {
                return .failure(.dataDecodingError)
            }

            return .success(value)

        } catch {
            return .failure(.clientError)
        }
}

}
