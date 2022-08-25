protocol QuizClientProtocol {

    var quizes: [QuizResponseClientModel] { get async throws }

    func getQuizes(for category: QuizCategoryClientModel) async throws -> [QuizResponseClientModel]

    func getLeaderboard(for quizId: Int) async throws -> [QuizLeaderboardResponseClientModel]

    func startQuizSession(for quizId: Int) async throws -> StartQuizSessionResponseClientModel

    func endQuizSession(
        with id: String,
        numberofCorrectQuestions: Int
    ) async throws -> EndQuizSessionResponseClientModel

}

class QuizClient: QuizClientProtocol {

    private let path = "/v1/quiz"
    private let networkClient: NetworkClientProtocol

    init(networkClient: NetworkClientProtocol) {
        self.networkClient = networkClient
    }

    var quizes: [QuizResponseClientModel] {
        get async throws {
            try await networkClient
                .executeRequest(path: "\(path)/list", method: .get, parameters: nil)
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

    func startQuizSession(for quizId: Int) async throws -> StartQuizSessionResponseClientModel {
        try await networkClient
            .executeRequest(path: "\(path)/\(quizId)/session/start", method: .post, parameters: nil)
    }

    func endQuizSession(
        with id: String,
        numberofCorrectQuestions: Int
    ) async throws -> EndQuizSessionResponseClientModel {
        try await networkClient
            .executeRequest(
                path: "\(path)/session/\(id)/end",
                method: .post,
                body: EndQuizSessionRequestClientModel(numberOfCorrectQuestions: numberofCorrectQuestions))
    }

}
