protocol QuizUseCaseProtocol {

    var quizes: [QuizModel] { get async throws }

    func getQuizes(for category: QuizCategoryModel) async throws -> [QuizModel]

    func getLeaderboard(for quizId: Int) async throws -> [QuizLeaderboardModel]

    func startQuizSession(for quizId: Int) async throws -> StartQuizSessionModel

}

class QuizUseCase: QuizUseCaseProtocol {

    private let quizDataSource: QuizDataSourceProtocol

    init(quizDataSource: QuizDataSourceProtocol) {
        self.quizDataSource = quizDataSource
    }

    var quizes: [QuizModel] {
        get async throws {
            try await quizDataSource
                .quizes
                .map { QuizModel(from: $0) }
        }
    }

    func getQuizes(for category: QuizCategoryModel) async throws -> [QuizModel] {
        try await quizDataSource
            .getQuizes(for: QuizCategoryDataModel(rawValue: category.rawValue)!)
            .map { QuizModel(from: $0) }
    }

    func getLeaderboard(for quizId: Int) async throws -> [QuizLeaderboardModel] {
        try await quizDataSource
            .getLeaderboard(for: quizId)
            .map { QuizLeaderboardModel(from: $0) }
    }

    func startQuizSession(for quizId: Int) async throws -> StartQuizSessionModel {
        StartQuizSessionModel(from: try await quizDataSource.startQuizSession(for: quizId))
    }

}
