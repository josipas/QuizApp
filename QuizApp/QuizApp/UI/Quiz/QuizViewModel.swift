class QuizViewModel {

    private let coordinator: CoordinatorProtocol

    init(coordinator: CoordinatorProtocol) {
        self.coordinator = coordinator
    }

    func getQuizCategories() -> [QuizCategory] {
        QuizCategory.allCases
    }
}
