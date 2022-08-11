struct StartQuizSessionDataModel: Codable {

    let sessionId: String
    let questions: [QuestionDataModel]

}

extension StartQuizSessionDataModel {

    init(from model: StartQuizSessionResponseClientModel) {
        sessionId = model.sessionId
        questions = model
            .questions
            .map { QuestionDataModel(from: $0) }
    }

}
