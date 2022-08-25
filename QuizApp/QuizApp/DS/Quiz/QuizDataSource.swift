protocol QuizDataSourceProtocol {

    var quizzes: [QuizResponseDataModel] { get async throws }

    func getQuizzes(for category: QuizCategoryDataModel) async throws -> [QuizResponseDataModel]

    func getLeaderboard(for quizId: Int) async throws -> [QuizLeaderboardDataModel]

    func startQuizSession(for quizId: Int) async throws -> StartQuizSessionDataModel

    func endQuizSession(with id: String, numberOfCorrectQuestions: Int) async throws -> EndQuizSessionDataModel

}

class QuizDataSource: QuizDataSourceProtocol {

    private let quizClient: QuizClientProtocol

    init(quizClient: QuizClientProtocol) {
        self.quizClient = quizClient
    }

    var quizzes: [QuizResponseDataModel] {
        get async throws {
            try await quizClient
                .quizzes
                .map { QuizResponseDataModel(from: $0) }
        }
    }

    func getQuizzes(for category: QuizCategoryDataModel) async throws -> [QuizResponseDataModel] {
        try await quizClient
            .getQuizzes(for: QuizCategoryClientModel(rawValue: category.rawValue)!)
            .map { QuizResponseDataModel(from: $0) }
    }

    func getLeaderboard(for quizId: Int) async throws -> [QuizLeaderboardDataModel] {
        try await quizClient
            .getLeaderboard(for: quizId)
            .map { QuizLeaderboardDataModel(from: $0) }
    }

    func startQuizSession(for quizId: Int) async throws -> StartQuizSessionDataModel {
        StartQuizSessionDataModel(from: try await quizClient.startQuizSession(for: quizId))
    }

    func endQuizSession(with id: String, numberOfCorrectQuestions: Int) async throws -> EndQuizSessionDataModel {
        EndQuizSessionDataModel(
            from: try await quizClient
                .endQuizSession(
                    with: id,
                    numberofCorrectQuestions: numberOfCorrectQuestions))
    }

}
