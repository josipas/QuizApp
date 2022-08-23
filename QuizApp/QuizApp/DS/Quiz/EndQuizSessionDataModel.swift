struct EndQuizSessionDataModel: Codable {

    let points: Int

}

extension EndQuizSessionDataModel {

    init(from model: EndQuizSessionResponseClientModel) {
        self.points = model.points
    }

}
