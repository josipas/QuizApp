struct StartQuizSessionResponseClientModel: Codable {

    let sessionId: String
    let questions: [QuestionClientModel]

}
