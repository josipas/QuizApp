protocol QuizUseCaseProtocol {

    func getQuizes(for category: QuizCategory) async throws -> [QuizModel]

}

class QuizUseCase: QuizUseCaseProtocol {

    private let quizDataSource: QuizDataSourceProtocol

    init(quizDataSource: QuizDataSourceProtocol) {
        self.quizDataSource = quizDataSource
    }

    func getQuizes(for category: QuizCategory) async throws -> [QuizModel] {
        try await quizDataSource.getQuizes(for: category).map {
            QuizModel(from: $0)
        }
    }

}
