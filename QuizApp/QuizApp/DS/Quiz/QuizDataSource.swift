protocol QuizDataSourceProtocol {

    func getQuizes(for category: QuizCategoryDataModel) async throws -> [QuizResponseDataModel]

    func getQuizes() async throws -> [QuizResponseDataModel]

}

class QuizDataSource: QuizDataSourceProtocol {

    private let quizClient: QuizClientProtocol

    init(quizClient: QuizClientProtocol) {
        self.quizClient = quizClient
    }

    func getQuizes(for category: QuizCategoryDataModel) async throws -> [QuizResponseDataModel] {
        try await quizClient
            .getQuizes(for: QuizCategoryClientModel(rawValue: category.rawValue)!)
            .map {
                QuizResponseDataModel(from: $0)
            }
    }

    func getQuizes() async throws -> [QuizResponseDataModel] {
        try await quizClient.getQuizes().map { QuizResponseDataModel(from: $0) }
    }

}
