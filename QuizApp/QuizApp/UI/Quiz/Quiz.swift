struct Quiz {

    let id: Int
    let name: String
    let description: String
    let category: QuizCategory
    let imageUrl: String
    let numberOfQuestions: Int
    let difficulty: QuizDifficultyLevel

}

extension Quiz {

    init(from model: QuizModel) {
        self.id = model.id
        self.name = model.name
        self.description = model.description
        self.category = QuizCategory(rawValue: model.category.rawValue)!
        self.imageUrl = model.imageUrl
        self.numberOfQuestions = model.numberOfQuestions
        self.difficulty = QuizDifficultyLevel(rawValue: model.difficulty.rawValue)!
    }

}
