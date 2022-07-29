protocol QuizDataSourceProtocol {

    func getQuizes(for category: QuizCategoryDataModel) async throws -> [QuizResponseDataModel]

}

class QuizDataSource: QuizDataSourceProtocol {

    private let quizClient: QuizClientProtocol

    init(quizClient: QuizClientProtocol) {
        self.quizClient = quizClient
    }

    func getQuizes(for category: QuizCategoryDataModel) async throws -> [QuizResponseDataModel] {
        try await quizClient.getQuizes(for: QuizCategoryClientModel(from: category)).map {
            QuizResponseDataModel(from: $0)
        }
    }

}
