struct QuizCategoryDataModel {

    let category: String

}

extension QuizCategoryDataModel {

    init(from model: QuizCategoryModel) {
        category = model.rawValue
    }

}
