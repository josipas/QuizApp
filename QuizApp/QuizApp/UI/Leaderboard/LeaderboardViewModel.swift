import Combine

struct Leaderboard {

    let name: String
    let points: Int

}

class LeaderboardViewModel {

    private let coordinator: CoordinatorProtocol

    @Published var leaderboardList: [Leaderboard] = []

    init(coordinator: CoordinatorProtocol) {
        self.coordinator = coordinator
    }

    func onXButtonTap() {
        coordinator.dismiss()
    }

    func getData(quizId: Int) {
        print(quizId)
    }

}
