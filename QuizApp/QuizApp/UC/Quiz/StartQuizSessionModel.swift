struct StartQuizSessionModel: Codable {

    let sessionId: String
    let questions: [QuestionModel]

}

extension StartQuizSessionModel {

    init(from model: StartQuizSessionDataModel) {
        sessionId = model.sessionId
        questions = model
            .questions
            .map { QuestionModel(from: $0) }
    }

}
