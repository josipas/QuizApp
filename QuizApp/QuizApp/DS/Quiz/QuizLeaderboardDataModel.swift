struct QuizLeaderboardDataModel: Codable {

    let name: String
    let points: Int

}

extension QuizLeaderboardDataModel {

    init(from model: QuizLeaderboardResponseClientModel) {
        self.name = model.name
        self.points = model.points
    }

}
