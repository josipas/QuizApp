import Combine
import UIKit

class QuizViewModel {

    private let coordinator: CoordinatorProtocol
    private let quizUseCase: QuizUseCaseProtocol

    @Published var categories: [CustomSegmentedControlModel] = []
    @Published var quizes: [QuizModel] = []

    init(coordinator: CoordinatorProtocol, quizUseCase: QuizUseCaseProtocol) {
        self.coordinator = coordinator
        self.quizUseCase = quizUseCase
    }

    @MainActor
    func loadData() {
        onCategorySelected(QuizCategoryModel.allCases[0])
    }

    @MainActor
    func loadQuizes(for category: QuizCategoryModel) {
        Task(priority: .background) {
            do {
                self.quizes = try await quizUseCase.getQuizes(for: category)
            } catch {
            }
        }
    }

    func loadCategories(active: QuizCategoryModel) {
        categories = QuizCategoryModel.allCases.compactMap {
            let isActive = active == $0
            return CustomSegmentedControlModel(
                id: $0.self,
                title: $0.rawValue.uppercased(),
                color: $0.color,
                isActive: isActive)
        }
    }

    @MainActor
    func onCategorySelected(_ category: QuizCategoryModel) {
        loadQuizes(for: category)
        loadCategories(active: category)
    }

}
