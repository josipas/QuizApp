struct QuestionClientModel: Decodable {

    let id: Int
    let question: String
    let answers: [AnswerClientModel]
    let correctAnswerId: Int

}
