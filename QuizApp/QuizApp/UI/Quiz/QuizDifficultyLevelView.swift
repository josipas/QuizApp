import UIKit

class QuizDifficultyLevelView: UIView {

    private var stackView: UIStackView!

    init() {
        super.init(frame: .zero)

        createViews()
        styleViews()
        defineLayoutForViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(color: UIColor, difficulty: QuizDifficultyLevelModel) {
        var elements = difficulty.elements

        for view in stackView.arrangedSubviews {
            view.tintColor = elements > 0 ? color : UIColor(red: 1, green: 1, blue: 1, alpha: 0.2)
            elements -= 1
        }
    }

    private func makeImage() -> UIImageView {
        let imageView = UIImageView(image: UIImage(systemName: "diamond.fill"))
        imageView.contentMode = .scaleAspectFill

        imageView.snp.makeConstraints {
            $0.width.height.equalTo(10)
        }

        return imageView
    }

}

extension QuizDifficultyLevelView: ConstructViewsProtocol {

    func createViews() {
        stackView = UIStackView()

        for _ in QuizDifficultyLevelModel.allCases {
            stackView.addArrangedSubview(makeImage())
        }

        addSubview(stackView)
    }

    func styleViews() {
        stackView.axis = .horizontal
        stackView.spacing = 5
    }

    func defineLayoutForViews() {
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }

}
