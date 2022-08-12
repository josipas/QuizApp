import UIKit

class QuizSessionCollectionViewCell: UICollectionViewCell {

    static let reuseIdentifier = String(describing: QuizSessionCollectionViewCell.self)

    private var questionLabel: UILabel!
    private var answersStack: UIStackView!

    override init(frame: CGRect) {
        super.init(frame: .zero)

        createViews()
        styleViews()
        defineLayoutForViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(question: Question) {
        answersStack
            .arrangedSubviews
            .forEach { $0.removeFromSuperview() }

        questionLabel.text = question.question

        for answer in question.answers {
            let answerView = AnswerView(answer: answer)
            answersStack.addArrangedSubview(answerView)
        }
    }

}

extension QuizSessionCollectionViewCell: ConstructViewsProtocol {

    func createViews() {
        questionLabel = UILabel()
        addSubview(questionLabel)

        answersStack = UIStackView()
        addSubview(answersStack)
    }

    func styleViews() {
        questionLabel.textColor = .white
        questionLabel.font = .systemFont(ofSize: 24, weight: .bold)
        questionLabel.numberOfLines = 0

        answersStack.spacing = 16
    }

    func defineLayoutForViews() {
        questionLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }

        answersStack.snp.makeConstraints {
            $0.top.equalTo(questionLabel.snp.bottom).offset(40)
            $0.trailing.leading.bottom.equalToSuperview()
        }
    }

}
