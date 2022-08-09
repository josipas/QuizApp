struct StartQuizSessionResponseClientModel: Decodable {

    let sessionId: String
    let questions: [QuestionClientModel]

}
