protocol QuizUseCaseProtocol {

    func getQuizes(for category: QuizCategoryModel) async throws -> [QuizModel]

    func getQuizes() async throws -> [QuizModel]

}

class QuizUseCase: QuizUseCaseProtocol {

    private let quizDataSource: QuizDataSourceProtocol

    init(quizDataSource: QuizDataSourceProtocol) {
        self.quizDataSource = quizDataSource
    }

    func getQuizes(for category: QuizCategoryModel) async throws -> [QuizModel] {
        try await quizDataSource
            .getQuizes(for: QuizCategoryDataModel(rawValue: category.rawValue)!)
            .map {
                QuizModel(from: $0)
            }
    }

    func getQuizes() async throws -> [QuizModel] {
        try await quizDataSource.getQuizes().map { QuizModel(from: $0) }
    }

}
