struct AnswerDataModel: Codable {

    let id: Int
    let answer: String

}

extension AnswerDataModel {

    init(from model: AnswerClientModel) {
        id = model.id
        answer = model.answer
    }

}
