import Combine

class SearchViewModel {

    private let coordinator: CoordinatorProtocol
    private let useCase: QuizUseCaseProtocol
    private var quizes: [Quiz] = []

    @Published var filteredQuizes: [QuizCategory: [Quiz]] = [:]

    init(coordinator: CoordinatorProtocol, useCase: QuizUseCaseProtocol) {
        self.coordinator = coordinator
        self.useCase = useCase
    }

    @MainActor
    func loadData() {
        Task(priority: .background) { [weak self] in
            guard let self = self else { return }

            do {
                var quizes: [QuizModel] = []

                quizes = try await useCase.quizes

                self.quizes = quizes.map { Quiz(from: $0) }
            } catch {
            }
        }
    }

    func onSearchButtonTap(text: String) {
        var filter: [Quiz] = []

        filter = quizes.filter {
            $0.name.lowercased().contains(text.lowercased())
        }

        filteredQuizes = Dictionary(grouping: filter, by: { $0.category })
    }

    func onQuizSelected(_ quiz: Quiz) {
        coordinator.showQuizDetails(of: quiz)
    }
}
