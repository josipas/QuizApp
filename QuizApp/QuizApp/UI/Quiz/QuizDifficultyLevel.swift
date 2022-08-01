enum QuizDifficultyLevel: String, CaseIterable {

    case easy = "EASY"
    case normal = "NORMAL"
    case hard = "HARD"

    var elements: Int {
        switch self {
        case .easy:
            return 1
        case .normal:
            return 2
        case .hard:
            return 3
        }
    }

}
