import UIKit

enum QuizCategory: String, CaseIterable {

    case all = "ALL"
    case movies = "MOVIES"
    case music = "MUSIC"
    case sport = "SPORT"
    case geography = "GEOGRAPHY"

    var name: String {
        switch self {
        case .all:
            return "All"
        case .movies:
            return "Movies"
        case .music:
            return "Music"
        case .sport:
            return "Sport"
        case .geography:
            return "Geography"
        }
    }

    var color: UIColor {
        switch self {
        case .all:
            return .white
        case .movies:
            return UIColor(red: 0.070, green: 0.690, blue: 0.901, alpha: 1)
        case .music:
            return UIColor(red: 0.988, green: 0.395, blue: 0.395, alpha: 1)
        case .sport:
            return UIColor(red: 0.949, green: 0.788, blue: 0.298, alpha: 1)
        case .geography:
            return UIColor(red: 0.179, green: 0.897, blue: 0.513, alpha: 1)
        }
    }

}
