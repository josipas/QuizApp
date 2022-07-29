import UIKit

enum QuizCategoryModel: String, CaseIterable, Codable {

    case movies
    case music
    case sport
    case geography

    var color: UIColor {
        switch self {
        case .geography:
            return UIColor(red: 0.179, green: 0.897, blue: 0.513, alpha: 1)
        case .movies:
            return UIColor(red: 0.118, green: 0.404, blue: 0.639, alpha: 1)
        case .music:
            return UIColor(red: 0.988, green: 0.395, blue: 0.395, alpha: 1)
        case .sport:
            return UIColor(red: 0.949, green: 0.788, blue: 0.298, alpha: 1)
        }
    }

}
