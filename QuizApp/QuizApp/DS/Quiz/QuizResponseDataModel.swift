struct QuizResponseDataModel: Codable {

    let id: Int
    let name: String
    let description: String
    let category: String
    let imageUrl: String
    let numberOfQuestions: Int
    let difficulty: String

}

extension QuizResponseDataModel {

    init(from model: QuizResponseClientModel) {
        self.id = model.id
        self.name = model.name
        self.description = model.description
        self.category = model.category
        self.imageUrl = model.imageUrl
        self.numberOfQuestions = model.numberOfQuestions
        self.difficulty = model.difficulty
    }

}
