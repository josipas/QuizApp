import Combine
import UIKit

class QuizDetailsViewModel {

    private let coordinator: CoordinatorProtocol

    init(coordinator: CoordinatorProtocol) {
        self.coordinator = coordinator
    }

    func onBackButtonClick() {
        coordinator.back()
    }

    func onStartQuizButtonClick(quizId: Int) {
    }

    func onLeaderboardButtonClick(quizId: Int) {
        coordinator.showLeaderboardViewController(quizId)
    }

}
