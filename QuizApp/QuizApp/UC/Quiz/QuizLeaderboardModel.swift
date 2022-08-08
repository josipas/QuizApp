struct QuizLeaderboardModel: Codable {

    let name: String
    let points: Int

}

extension QuizLeaderboardModel {

    init(from model: QuizLeaderboardDataModel) {
        self.name = model.name
        self.points = model.points
    }

}
