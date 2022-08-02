protocol QuizClientProtocol {

    var quizes: [QuizResponseClientModel] { get async throws }

    func getQuizes(for category: QuizCategoryClientModel) async throws -> [QuizResponseClientModel]

}

class QuizClient: QuizClientProtocol {

    private let path = "/v1/quiz/list"
    private let networkClient: NetworkClientProtocol

    init(networkClient: NetworkClientProtocol) {
        self.networkClient = networkClient
    }

    var quizes: [QuizResponseClientModel] {
        get async throws {
            try await networkClient.executeRequest(path: path, method: .get, parameters: nil)
        }
    }

    func getQuizes(for category: QuizCategoryClientModel) async throws -> [QuizResponseClientModel] {
        try await networkClient.executeRequest(
            path: path,
            method: .get,
            parameters: ["category": category.rawValue])
    }

}
