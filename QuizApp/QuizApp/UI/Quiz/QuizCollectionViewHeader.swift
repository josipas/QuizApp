import UIKit

class QuizCollectionViewHeader: UICollectionReusableView {

    static let reuseIdentifier = String(describing: QuizCollectionViewHeader.self)

    private var label: UILabel!

    override init(frame: CGRect) {
        super.init(frame: .zero)

        createViews()
        styleViews()
        defineLayoutForViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(category: QuizCategory) {
        label.text = category.name
        label.textColor = category.color
    }
}

extension QuizCollectionViewHeader: ConstructViewsProtocol {

    func createViews() {
        label = UILabel()
        addSubview(label)
    }

    func styleViews() {
        label.font = .systemFont(ofSize: 20, weight: .bold)
    }

    func defineLayoutForViews() {
        label.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(5)
            $0.bottom.equalToSuperview().inset(10)
        }
    }

}
