struct QuizModel: Codable {

    let id: Int
    let name: String
    let description: String
    let category: QuizCategoryModel
    let imageUrl: String
    let numberOfQuestions: Int
    let difficulty: QuizDifficultyLevelModel

}

extension QuizModel {

    init(from model: QuizResponseDataModel) {
        self.id = model.id
        self.name = model.name
        self.description = model.description
        self.category = QuizCategoryModel(rawValue: model.category.rawValue)!
        self.imageUrl = model.imageUrl
        self.numberOfQuestions = model.numberOfQuestions
        self.difficulty = QuizDifficultyLevelModel(rawValue: model.difficulty.rawValue)!
    }

}
