struct QuestionModel: Codable {

    let id: Int
    let question: String
    let answers: [AnswerModel]
    let correctAnswerId: Int

}

extension QuestionModel {

    init(from model: QuestionDataModel) {
        id = model.id
        question = model.question
        answers = model
            .answers
            .map { AnswerModel(from: $0) }
        correctAnswerId = model.correctAnswerId
    }

}
