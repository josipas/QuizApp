import Combine

class SearchViewModel {

    private let coordinator: CoordinatorProtocol
    private let useCase: QuizUseCaseProtocol
    private var quizzes: [Quiz] = []

    @Published var filteredQuizzes: [QuizCategory: [Quiz]] = [:]
    @Published var hasErrorOccurred: Bool = false

    init(coordinator: CoordinatorProtocol, useCase: QuizUseCaseProtocol) {
        self.coordinator = coordinator
        self.useCase = useCase
    }

    @MainActor
    func loadData() {
        Task(priority: .background) { [weak self] in
            guard let self = self else { return }

            do {
                var quizzes: [QuizModel] = []

                quizzes = try await useCase.quizzes

                self.hasErrorOccurred = false
                self.quizzes = quizzes.map { Quiz(from: $0) }
            } catch {
                self.hasErrorOccurred = true
            }
        }
    }

    func onSearchButtonTap(text: String) {
        var filter: [Quiz] = []

        filter = quizzes.filter {
            $0.name.lowercased().contains(text.lowercased())
        }

        filteredQuizzes = Dictionary(grouping: filter, by: { $0.category })
    }

    func onQuizSelected(_ quiz: Quiz) {
        coordinator.showQuizDetails(of: quiz)
    }
}
