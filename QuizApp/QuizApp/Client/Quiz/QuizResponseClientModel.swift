struct QuizResponseClientModel: Codable {

    let id: Int
    let name: String
    let description: String
    let category: String
    let imageUrl: String
    let numberOfQuestions: Int
    let difficulty: String

}
