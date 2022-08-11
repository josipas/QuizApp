import Combine
import UIKit

class QuizViewModel {

    private let coordinator: CoordinatorProtocol
    private let useCase: QuizUseCaseProtocol

    @Published var categories: [CustomSegmentedControlModel] = []
    @Published var quizes: [QuizCategory: [Quiz]] = [:]
    @Published var hasErrorOcurred: Bool = false

    init(coordinator: CoordinatorProtocol, useCase: QuizUseCaseProtocol) {
        self.coordinator = coordinator
        self.useCase = useCase
    }

    @MainActor
    func loadData() {
        onCategorySelected(QuizCategory.allCases[1])
    }

    @MainActor
    func loadQuizes(for category: QuizCategory) {
        Task(priority: .background) { [weak self] in
            guard let self = self else { return }

            do {
                var quizes: [QuizModel] = []

                if category != .all {
                    quizes = try await useCase.getQuizes(for: QuizCategoryModel(rawValue: category.rawValue)!)
                } else {
                    quizes = try await useCase.quizes
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
        coordinator.showQuizDetails(of: quiz)
    }

}
