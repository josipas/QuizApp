struct QuizCategoryClientModel {

    let category: String

}

extension QuizCategoryClientModel {

    init(from model: QuizCategoryDataModel) {
        self.category = model.category
    }

}
