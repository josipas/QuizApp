struct EndQuizSessionModel: Codable {

    let points: Int

}

extension EndQuizSessionModel {

    init(from model: EndQuizSessionDataModel) {
        self.points = model.points
    }

}
