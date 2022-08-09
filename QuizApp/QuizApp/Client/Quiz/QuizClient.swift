protocol QuizClientProtocol {

    var quizes: [QuizResponseClientModel] { get async throws }

    func getQuizes(for category: QuizCategoryClientModel) async throws -> [QuizResponseClientModel]

    func getLeaderboard(for quizId: Int) async throws -> [QuizLeaderboardResponseClientModel]

}

class QuizClient: QuizClientProtocol {

    private let path = "/v1/quiz"
    private let networkClient: NetworkClientProtocol

    init(networkClient: NetworkClientProtocol) {
        self.networkClient = networkClient
    }

    var quizes: [QuizResponseClientModel] {
        get async throws {
            try await networkClient.executeRequest(path: "\(path)/list", method: .get, parameters: nil)
        }
    }

    func getQuizes(for category: QuizCategoryClientModel) async throws -> [QuizResponseClientModel] {
        try await networkClient
            .executeRequest(
                path: "\(path)/list",
                method: .get,
                parameters: ["category": category.rawValue])
    }

    func getLeaderboard(for quizId: Int) async throws -> [QuizLeaderboardResponseClientModel] {
        try await networkClient
            .executeRequest(
                path: "\(path)/leaderboard",
                method: .get,
                parameters: ["quizId": String(quizId)])
    }

}
