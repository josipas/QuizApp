struct AnswerModel: Codable {

    let id: Int
    let answer: String

}

extension AnswerModel {

    init(from model: AnswerDataModel) {
        id = model.id
        answer = model.answer
    }

}
