struct QuizResponseDataModel: Codable {

    let id: Int
    let name: String
    let description: String
    let category: QuizCategoryDataModel
    let imageUrl: String
    let numberOfQuestions: Int
    let difficulty: QuizDifficultyLevelDataModel

}

extension QuizResponseDataModel {

    init(from model: QuizResponseClientModel) {
        self.id = model.id
        self.name = model.name
        self.description = model.description
        self.category = QuizCategoryDataModel(rawValue: model.category.rawValue)!
        self.imageUrl = model.imageUrl
        self.numberOfQuestions = model.numberOfQuestions
        self.difficulty = QuizDifficultyLevelDataModel(rawValue: model.difficulty.rawValue)!
    }

}
