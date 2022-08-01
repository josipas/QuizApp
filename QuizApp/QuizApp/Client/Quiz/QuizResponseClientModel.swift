struct QuizResponseClientModel: Codable {

    let id: Int
    let name: String
    let description: String
    let category: QuizCategoryClientModel
    let imageUrl: String
    let numberOfQuestions: Int
    let difficulty: QuizDifficultyLevelClientModel

}
