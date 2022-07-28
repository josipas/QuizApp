import Combine
import UIKit

struct Quiz {
    let id: Int
    let name: String
    let description: String
    let category: QuizCategory
    let imageUrl: String
    let numberOfQuestions: Int
    let difficulty: QuizDifficultyLevel
}

class QuizViewModel {

    private let coordinator: CoordinatorProtocol

    @Published var categories: [QuizCategory] = []
    @Published var quizes: [Quiz] = []

    init(coordinator: CoordinatorProtocol) {
        self.coordinator = coordinator
    }

    func getData() {
        categories = QuizCategory.allCases
        getQuizes(for: categories[0])
    }

    func getQuizes(for category: QuizCategory) {
        switch category {
        case .sport:
            quizes = [
                Quiz(
                    id: 1,
                    name: "Football quiz",
                    description: "Test your basic knowledge of football",
                    category: .sport,
                    imageUrl: "",
                    numberOfQuestions: 5,
                    difficulty: .easy),
                Quiz(
                    id: 2,
                    name: "Tennis quiz",
                    description: "Test your knowledge of tennis world",
                    category: .sport,
                    imageUrl: "",
                    numberOfQuestions: 5,
                    difficulty: .normal)]
        case .movies:
            quizes = [
                Quiz(
                    id: 3,
                    name: "Oscars quiz",
                    description: "The most prestige awards!",
                    category: .movies,
                    imageUrl: "",
                    numberOfQuestions: 5,
                    difficulty: .normal),
                Quiz(
                    id: 4,
                    name: "Stars quiz",
                    description: "Young & famous!",
                    category: .movies,
                    imageUrl: "",
                    numberOfQuestions: 5,
                    difficulty: .easy)]
        default:
            quizes = []
        }
    }
}
