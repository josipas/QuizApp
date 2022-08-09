protocol QuizDataSourceProtocol {

    var quizes: [QuizResponseDataModel] { get async throws }

    func getQuizes(for category: QuizCategoryDataModel) async throws -> [QuizResponseDataModel]

    func getLeaderboard(for quizId: Int) async throws -> [QuizLeaderboardDataModel]

}

class QuizDataSource: QuizDataSourceProtocol {

    private let quizClient: QuizClientProtocol

    init(quizClient: QuizClientProtocol) {
        self.quizClient = quizClient
    }

    var quizes: [QuizResponseDataModel] {
        get async throws {
            try await quizClient.quizes.map { QuizResponseDataModel(from: $0) }
        }
    }

    func getQuizes(for category: QuizCategoryDataModel) async throws -> [QuizResponseDataModel] {
        try await quizClient
            .getQuizes(for: QuizCategoryClientModel(rawValue: category.rawValue)!)
            .map {
                QuizResponseDataModel(from: $0)
            }
    }

    func getLeaderboard(for quizId: Int) async throws -> [QuizLeaderboardDataModel] {
        try await quizClient
            .getLeaderboard(for: quizId)
            .map {
                QuizLeaderboardDataModel(from: $0)
            }
    }

}
