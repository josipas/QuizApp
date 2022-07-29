protocol QuizDataSourceProtocol {

    func getQuizes(for category: QuizCategory) async throws -> [QuizResponseDataModel]

}

class QuizDataSource: QuizDataSourceProtocol {

    private let quizClient: QuizClientProtocol

    init(quizClient: QuizClientProtocol) {
        self.quizClient = quizClient
    }

    func getQuizes(for category: QuizCategory) async throws -> [QuizResponseDataModel] {
        try await quizClient.getQuizes(for: category).map {
            QuizResponseDataModel(from: $0)
        }
    }

}
