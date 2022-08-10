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
        Task(priority: .background) { [weak self] in
            guard let self = self else { return }

            do {
                self.leaderboardList = try await useCase.getLeaderboard(for: quizId).map { QuizLeaderboard(from: $0) }
            } catch {
            }
        }
    }

}
