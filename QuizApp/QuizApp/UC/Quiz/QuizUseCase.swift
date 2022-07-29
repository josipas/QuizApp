protocol QuizUseCaseProtocol {

    func getQuizes(for category: QuizCategoryModel) async throws -> [QuizModel]

}

class QuizUseCase: QuizUseCaseProtocol {

    private let quizDataSource: QuizDataSourceProtocol

    init(quizDataSource: QuizDataSourceProtocol) {
        self.quizDataSource = quizDataSource
    }

    func getQuizes(for category: QuizCategoryModel) async throws -> [QuizModel] {
        try await quizDataSource.getQuizes(for: QuizCategoryDataModel(from: category)).map {
            QuizModel(from: $0)
        }
    }

}
