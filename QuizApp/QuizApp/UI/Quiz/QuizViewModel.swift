import Combine
import UIKit

class QuizViewModel {

    private let coordinator: CoordinatorProtocol
    private let quizUseCase: QuizUseCaseProtocol

    @Published var categories: [CustomSegmentedControlModel] = []
    @Published var quizes: [QuizCategory: [Quiz]] = [:]

    init(coordinator: CoordinatorProtocol, quizUseCase: QuizUseCaseProtocol) {
        self.coordinator = coordinator
        self.quizUseCase = quizUseCase
    }

    @MainActor
    func loadData() {
        onCategorySelected(QuizCategory.allCases[0])
    }

    @MainActor
    func loadQuizes(for category: QuizCategory) {
        Task(priority: .background) {
            do {
                var quizes: [QuizModel] = []

                if category != .all {
                    quizes = try await quizUseCase.getQuizes(for: QuizCategoryModel(rawValue: category.rawValue)!)
                } else {
                    quizes = try await quizUseCase.getQuizes()
                }

                self.quizes = quizes
                    .map {
                        Quiz(from: $0)
                    }
                    .reduce([QuizCategory: [Quiz]]()) { (dict, quiz) -> [QuizCategory: [Quiz]] in
                        var dict = dict
                        dict[quiz.category] == nil ? dict[quiz.category] = [quiz] : dict[quiz.category]?.append(quiz)
                        return dict
                    }
            } catch {
            }
        }
    }

    func loadCategories(active: QuizCategory) {
        categories = QuizCategory.allCases.compactMap {
            let isActive = active == $0
            return CustomSegmentedControlModel(
                id: $0.self,
                title: $0.rawValue,
                color: $0.color,
                isActive: isActive)
        }
    }

    @MainActor
    func onCategorySelected(_ category: QuizCategory) {
        loadQuizes(for: category)
        loadCategories(active: category)
    }

}
