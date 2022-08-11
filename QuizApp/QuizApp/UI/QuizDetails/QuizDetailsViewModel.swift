import Combine
import UIKit

class QuizDetailsViewModel {

    private let coordinator: CoordinatorProtocol

    @Published var quiz: Quiz

    init(coordinator: CoordinatorProtocol, quiz: Quiz) {
        self.coordinator = coordinator
        self.quiz = quiz
    }

    func onBackButtonClick() {
        coordinator.goBack()
    }

    func onStartQuizButtonClick() {
        coordinator.showQuiz(quizId: quiz.id)
    }

    func onLeaderboardButtonClick() {
        coordinator.showLeaderboard(quizId: quiz.id)
    }

}
