import Combine

class LeaderboardViewModel {

    private let coordinator: CoordinatorProtocol
    private let quizUseCase: QuizUseCaseProtocol

    private var quizId: Int

    @Published var leaderboardList: [QuizLeaderboard] = []

    init(coordinator: CoordinatorProtocol, quizUseCase: QuizUseCaseProtocol, quizId: Int) {
        self.coordinator = coordinator
        self.quizUseCase = quizUseCase
        self.quizId = quizId
    }

    func onXButtonTap() {
        coordinator.hideLeaderboard()
    }

    @MainActor
    func loadData() {
        Task(priority: .background) {
            do {
                leaderboardList = try await quizUseCase.getLeaderboard(for: quizId).map { QuizLeaderboard(from: $0) }
            } catch {
            }
        }
    }

}
