protocol QuizUseCaseProtocol {

    var quizes: [QuizModel] { get async throws }

    func getQuizes(for category: QuizCategoryModel) async throws -> [QuizModel]

}

class QuizUseCase: QuizUseCaseProtocol {

    private let quizDataSource: QuizDataSourceProtocol

    init(quizDataSource: QuizDataSourceProtocol) {
        self.quizDataSource = quizDataSource
    }

    var quizes: [QuizModel] {
        get async throws {
            try await quizDataSource.quizes.map { QuizModel(from: $0) }
        }
    }

    func getQuizes(for category: QuizCategoryModel) async throws -> [QuizModel] {
        try await quizDataSource
            .getQuizes(for: QuizCategoryDataModel(rawValue: category.rawValue)!)
            .map {
                QuizModel(from: $0)
            }
    }

}
