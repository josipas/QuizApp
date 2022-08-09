import Combine

class LeaderboardViewModel {

    private let coordinator: CoordinatorProtocol
    private let useCase: QuizUseCaseProtocol

    private let quizId: Int

    @Published var leaderboardList: [QuizLeaderboard] = []

    init(coordinator: CoordinatorProtocol, useCase: QuizUseCaseProtocol, quizId: Int) {
        self.coordinator = coordinator
        self.useCase = useCase
        self.quizId = quizId
    }

    func onXButtonTap() {
        coordinator.hideLeaderboard()
    }

    @MainActor
    func loadData() {
        Task(priority: .background) {
            do {
                leaderboardList = try await useCase.getLeaderboard(for: quizId).map { QuizLeaderboard(from: $0) }
            } catch {
            }
        }
    }

}
