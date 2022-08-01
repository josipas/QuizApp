import Combine
import UIKit

class QuizViewModel {

    private let coordinator: CoordinatorProtocol
    private let quizUseCase: QuizUseCaseProtocol

    @Published var categories: [CustomSegmentedControlModel] = []
    @Published var quizes: [Quiz] = []
    @Published var allSelected = false

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
                if category != .all {
                    self.quizes = try await quizUseCase
                        .getQuizes(for: QuizCategoryModel(rawValue: category.rawValue)!).map {
                            Quiz(from: $0)
                        }
                } else {
                    self.allSelected = true
                    self.quizes = try await quizUseCase.getQuizes().map {
                        Quiz(from: $0)
                    }
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
                title: $0.rawValue.uppercased(),
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
