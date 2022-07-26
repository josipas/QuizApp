enum QuizCategory: CaseIterable {
    case geography
    case movies
    case music
    case sport

    var description: String {
        switch self {
        case .geography:
            return "GEOGRAPHY"
        case .movies:
            return "MOVIES"
        case .music:
            return "MUSIC"
        case .sport:
            return "SPORT"
        }
    }
}
