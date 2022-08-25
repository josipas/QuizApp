import Combine
import UIKit

class QuizViewModel {

    private let coordinator: CoordinatorProtocol
    private let useCase: QuizUseCaseProtocol

    @Published var categories: [CustomSegmentedControlModel] = []
    @Published var quizzes: [QuizCategory: [Quiz]] = [:]
    @Published var hasErrorOccurred: Bool = false

    init(coordinator: CoordinatorProtocol, useCase: QuizUseCaseProtocol) {
        self.coordinator = coordinator
        self.useCase = useCase
    }

    @MainActor
    func loadData() {
        onCategorySelected(QuizCategory.allCases[1])
    }

    @MainActor
    func loadQuizzes(for category: QuizCategory) {
        Task(priority: .background) { [weak self] in
            guard let self = self else { return }

            do {
                var quizzes: [QuizModel] = []

                if category != .all {
                    quizzes = try await useCase.getQuizzes(for: QuizCategoryModel(rawValue: category.rawValue)!)
                } else {
                    quizzes = try await useCase.quizzes
                }

                self.hasErrorOccurred = false
                self.quizzes = Dictionary(grouping: quizzes.map { Quiz(from: $0) }, by: { $0.category })
            } catch {
                self.hasErrorOccurred = true
            }
        }
    }

    func loadCategories(active: QuizCategory) {
        categories = QuizCategory.allCases.compactMap {
            let isActive = active == $0
            return CustomSegmentedControlModel(
                id: $0.self,
                title: $0.name.uppercased(),
                color: $0.color,
                isActive: isActive)
        }
    }

    @MainActor
    func onCategorySelected(_ category: QuizCategory) {
        loadQuizzes(for: category)
        loadCategories(active: category)
    }

    func onQuizSelected(_ quiz: Quiz) {
        coordinator.showQuizDetails(of: quiz)
    }

}
