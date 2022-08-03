import Combine
import UIKit

class QuizViewModel {

    private let coordinator: CoordinatorProtocol
    private let quizUseCase: QuizUseCaseProtocol

    @Published var categories: [CustomSegmentedControlModel] = []
    @Published var quizes: [QuizCategory: [Quiz]] = [:]
    @Published var hasErrorOcurred: Bool = false

    init(coordinator: CoordinatorProtocol, quizUseCase: QuizUseCaseProtocol) {
        self.coordinator = coordinator
        self.quizUseCase = quizUseCase
    }

    @MainActor
    func loadData() {
        onCategorySelected(QuizCategory.allCases[1])
    }

    @MainActor
    func loadQuizes(for category: QuizCategory) {
        Task(priority: .background) {
            do {
                var quizes: [QuizModel] = []

                if category != .all {
                    quizes = try await quizUseCase.getQuizes(for: QuizCategoryModel(rawValue: category.rawValue)!)
                } else {
                    quizes = try await quizUseCase.quizes
                }

                self.hasErrorOcurred = false
                self.quizes = Dictionary(grouping: quizes.map { Quiz(from: $0) }, by: { $0.category })
            } catch {
                self.hasErrorOcurred = true
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
        loadQuizes(for: category)
        loadCategories(active: category)
    }

    func onQuizSelected(_ quiz: Quiz) {
        coordinator.showQuizDetailsController(quiz)
    }

}
