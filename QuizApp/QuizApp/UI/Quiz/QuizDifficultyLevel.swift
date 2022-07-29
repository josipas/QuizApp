enum QuizDifficultyLevel: CaseIterable {

    case easy
    case normal
    case hard

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