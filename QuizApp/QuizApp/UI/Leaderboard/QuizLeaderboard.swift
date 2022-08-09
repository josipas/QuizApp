struct QuizLeaderboard: Codable {

    let name: String
    let points: Int

}

extension QuizLeaderboard {

    init(from model: QuizLeaderboardModel) {
        self.name = model.name
        self.points = model.points
    }

}
