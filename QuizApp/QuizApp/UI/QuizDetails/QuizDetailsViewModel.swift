import Combine
import UIKit

class QuizDetailsViewModel {

    private let coordinator: CoordinatorProtocol

    init(coordinator: CoordinatorProtocol) {
        self.coordinator = coordinator
    }

    func onBackButtonTap() {
        coordinator.back()
    }

    func onStartQuizButtonTap(quizId: Int) {
    }

    func onLeaderboardButtonTap(quizId: Int) {
    }

}
