import Combine

class QuizResultViewModel {

    private let sessionId: String
    private let numberOfCorrectQuestions: Int
    private let numberOfQuestions: Int
    private let useCase: QuizUseCaseProtocol
    private let coordinator: CoordinatorProtocol

    @Published var result: String = ""

    init(
        sessionId: String,
        numberOfCorrectQuestions: Int,
        numberOfQuestions: Int,
        useCase: QuizUseCaseProtocol,
        coordinator: CoordinatorProtocol) {
            self.sessionId = sessionId
            self.numberOfCorrectQuestions = numberOfCorrectQuestions
            self.numberOfQuestions = numberOfQuestions
            self.useCase = useCase
            self.coordinator = coordinator
        }

    @MainActor
    func onSubmitButtonTap() {
        Task(priority: .background) {
            do {
                _ = try await useCase
                    .endQuizSession(
                        with: sessionId,
                        numberOfCorrectQuestions: numberOfCorrectQuestions)

                coordinator.showHome()
            } catch {
            }
        }
    }

    func loadData() {
        result = "\(numberOfCorrectQuestions)/\(numberOfQuestions)"
    }

}
