class QuestionViewModel {

    private let useCase: QuizUseCaseProtocol
    private let quizId: Int

    init(useCase: QuizUseCaseProtocol, quizId: Int) {
        self.useCase = useCase
        self.quizId = quizId
    }

    func loadData() {
        Task(priority: .background) {
            do {
                let quizData = try await useCase.startQuizSession(for: quizId)
            } catch {
            }
        }
    }

}
