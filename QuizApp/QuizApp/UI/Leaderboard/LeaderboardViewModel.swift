import Combine

class LeaderboardViewModel {

    private let coordinator: CoordinatorProtocol
    private let quizUseCase: QuizUseCaseProtocol

    @Published var leaderboardList: [QuizLeaderboard] = []

    init(coordinator: CoordinatorProtocol, quizUseCase: QuizUseCaseProtocol) {
        self.coordinator = coordinator
        self.quizUseCase = quizUseCase
    }

    func onXButtonTap() {
        coordinator.dismiss()
    }

    @MainActor
    func getData(quizId: Int) {
        Task(priority: .background) {
            do {
                leaderboardList = try await quizUseCase.getLeaderboard(for: quizId).map { QuizLeaderboard(from: $0) }
            } catch {
            }
        }
    }

}
