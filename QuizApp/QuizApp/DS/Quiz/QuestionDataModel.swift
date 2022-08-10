struct QuestionDataModel: Codable {

    let id: Int
    let question: String
    let answers: [AnswerDataModel]
    let correctAnswerId: Int

}

extension QuestionDataModel {

    init(from model: QuestionClientModel) {
        id = model.id
        question = model.question
        answers = model
            .answers
            .map { AnswerDataModel(from: $0) }
        correctAnswerId = model.correctAnswerId
    }

}
