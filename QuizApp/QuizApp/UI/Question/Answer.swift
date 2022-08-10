import UIKit

struct Answer {

    let id: Int
    let answer: String
    let backgroundColor: UIColor

}

extension Answer {

    init(from model: AnswerModel) {
        id = model.id
        answer =  model.answer
        backgroundColor = .white.withAlphaComponent(0.3)
    }

}
