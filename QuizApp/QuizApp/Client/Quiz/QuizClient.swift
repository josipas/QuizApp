protocol QuizClientProtocol {

    func getQuizes(for category: QuizCategoryClientModel) async throws -> [QuizResponseClientModel]

}

class QuizClient: QuizClientProtocol {

    private let path = "/v1/quiz/list"
    private let networkClient: NetworkClientProtocol

    init(networkClient: NetworkClientProtocol) {
        self.networkClient = networkClient
    }

    func getQuizes(for category: QuizCategoryClientModel) async throws -> [QuizResponseClientModel] {
        try await networkClient.executeRequest(
            path: path,
            method: .get,
            parameters: ["category": category.category])
    }

}
