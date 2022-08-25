import Combine
import UIKit

class QuizSessionViewModel {

    private let useCase: QuizUseCaseProtocol
    private let coordinator: CoordinatorProtocol
    private let quizId: Int
    private let correctAnswerColor = UIColor(red: 0.435, green: 0.812, blue: 0.592, alpha: 1)
    private let incorrectAnswerColor = UIColor(red: 0.988, green: 0.395, blue: 0.395, alpha: 1)
    private var quizData: StartQuizSessionModel!
    private var selectedAnswerIds: [Int] = []
    private var numberOfCorrectAnswers = 0

    @Published var currentQuestionIndex = 0
    @Published var questions: [Question] = []

    init(coordinator: CoordinatorProtocol, useCase: QuizUseCaseProtocol, quizId: Int) {
        self.coordinator = coordinator
        self.useCase = useCase
        self.quizId = quizId
    }

    @MainActor
    func loadData() {
        Task(priority: .background) { [weak self] in
            guard let self = self else { return }

            do {
                self.quizData = try await useCase.startQuizSession(for: quizId)
                self.recalculateData()
            } catch {
            }
        }
    }

    func onAnswerClick(answerId: Int) {
        selectedAnswerIds.append(answerId)
        recalculateData()

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            guard let self = self else { return }

            var questions: [Question] = []

            for (index, question) in self.questions.enumerated() {
                if index == self.selectedAnswerIds.count {
                    questions
                        .append(
                            Question(
                                id: question.id,
                                question: question.question,
                                answers: question.answers,
                                progressColor: .white))
                } else {
                    questions.append(question)
                }
            }

            self.questions = questions

            if self.currentQuestionIndex < self.questions.count - 1 {
                self.currentQuestionIndex = self.selectedAnswerIds.count
            } else {
                questions.forEach { question in
                    if question.progressColor == self.correctAnswerColor {
                        self.numberOfCorrectAnswers += 1
                    }
                }
                self.coordinator
                    .showQuizResult(
                        session: EndSessionData(
                            sessionId: self.quizData.sessionId,
                            numberOfCorrectQuestions: self.numberOfCorrectAnswers,
                            numberOfQuestions: self.questions.count))
            }
        }
    }

    func onBackButtonClick() {
        coordinator.goBack()
    }

    private func recalculateData() {
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

            if index >= selectedAnswerIds.count {
                progressColor = index == 0 ? .white : .white.withAlphaComponent(0.5)
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
        if selectedAnswerIds.isEmpty {
            self.currentQuestionIndex = selectedAnswerIds.count
        }
    }

}
