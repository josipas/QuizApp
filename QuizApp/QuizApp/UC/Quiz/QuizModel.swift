struct QuizModel: Codable {

    let id: Int
    let name: String
    let description: String
    let category: QuizCategory?
    let imageUrl: String
    let numberOfQuestions: Int
    let difficulty: QuizDifficultyLevel?

}

extension QuizModel {

    init(from model: QuizResponseDataModel) {
        self.id = model.id
        self.name = model.name
        self.description = model.description
        self.category = QuizCategory(rawValue: model.category.lowercased())
        self.imageUrl = model.imageUrl
        self.numberOfQuestions = model.numberOfQuestions
        self.difficulty = QuizDifficultyLevel(rawValue: model.difficulty.lowercased())
    }

}
