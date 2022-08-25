protocol QuizUseCaseProtocol {

    var quizzes: [QuizModel] { get async throws }

    func getQuizzes(for category: QuizCategoryModel) async throws -> [QuizModel]

    func getLeaderboard(for quizId: Int) async throws -> [QuizLeaderboardModel]

    func startQuizSession(for quizId: Int) async throws -> StartQuizSessionModel

    func endQuizSession(with id: String, numberOfCorrectQuestions: Int) async throws -> EndQuizSessionModel

}

class QuizUseCase: QuizUseCaseProtocol {

    private let quizDataSource: QuizDataSourceProtocol

    init(quizDataSource: QuizDataSourceProtocol) {
        self.quizDataSource = quizDataSource
    }

    var quizzes: [QuizModel] {
        get async throws {
            try await quizDataSource
                .quizzes
                .map { QuizModel(from: $0) }
        }
    }

    func getQuizzes(for category: QuizCategoryModel) async throws -> [QuizModel] {
        try await quizDataSource
            .getQuizzes(for: QuizCategoryDataModel(rawValue: category.rawValue)!)
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

    func endQuizSession(with id: String, numberOfCorrectQuestions: Int) async throws -> EndQuizSessionModel {
        EndQuizSessionModel(
            from: try await quizDataSource
                .endQuizSession(
                    with: id,
                    numberOfCorrectQuestions: numberOfCorrectQuestions))
    }

}
