struct QuestionClientModel: Codable {

    let id: Int
    let question: String
    let answers: [AnswerClientModel]
    let correctAnswerId: Int

}
