import Combine
import UIKit

class QuizSessionViewModel {

    private let useCase: QuizUseCaseProtocol
    private let coordinator: CoordinatorProtocol
    private let quizId: Int

    private var quizData: StartQuizSessionModel!
    private var selectedAnswerIds: [Int] = []

    @Published var currentQuestionIndex = 0
    @Published var questions: [Question] = []

    init(coordinator: CoordinatorProtocol, useCase: QuizUseCaseProtocol, quizId: Int) {
        self.coordinator = coordinator
        self.useCase = useCase
        self.quizId = quizId
    }

    func loadData() {
        Task(priority: .background) { [weak self] in
            guard let self = self else { return }

            do {
                self.quizData = try await useCase.startQuizSession(for: quizId)
                self.currentQuestionIndex = 0
                self.recalculateData()
            } catch {
            }
        }
    }

    func onAnswerClick(answerId: Int) {
        selectedAnswerIds.append(answerId)
        recalculateData()

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            guard let self = self else { return }

            if self.currentQuestionIndex < self.questions.count - 1 {
                self.currentQuestionIndex += 1
            } else {
                self.coordinator.showQuizResult()
            }
        }
    }

    func onBackButtonClick() {
        coordinator.goBack()
    }

    private func recalculateData() {
        let correctAnswerColor = UIColor(red: 0.435, green: 0.812, blue: 0.592, alpha: 1)
        let incorrectAnswerColor = UIColor(red: 0.988, green: 0.395, blue: 0.395, alpha: 1)
        var questions: [Question] = []

        for (index, questionModel) in quizData.questions.enumerated() {
            let progressColor: UIColor

            let answers = questionModel
                .answers
                .map { answer -> Answer in
                    let backgroundColor: UIColor

                    if index >= selectedAnswerIds.count {
                        backgroundColor = .white.withAlphaComponent(0.3)
                    } else {
                        let selectedAnswerId = selectedAnswerIds[index]
                        let isCorrect = questionModel.correctAnswerId == answer.id
                        let isSelected = answer.id == selectedAnswerId

                        backgroundColor = isCorrect ?
                            correctAnswerColor :
                            isSelected ?
                                incorrectAnswerColor :
                                .white.withAlphaComponent(0.3)
                    }

                    return Answer(id: answer.id, answer: answer.answer, backgroundColor: backgroundColor)
                }

            if index > selectedAnswerIds.count {
                progressColor = .white.withAlphaComponent(0.5)
            } else if index == selectedAnswerIds.count {
                progressColor = .white
            } else {
                progressColor = quizData.questions[index].correctAnswerId == selectedAnswerIds[index] ?
                    correctAnswerColor :
                    incorrectAnswerColor
            }

            questions
                .append(Question(
                        id: questionModel.id,
                        question: questionModel.question,
                        answers: answers,
                        progressColor: progressColor))
        }

        self.questions = questions
    }

}
