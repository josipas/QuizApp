import UIKit

protocol QuizSessionCollectionViewCellDelegate: AnswerViewDelegate {
}

class QuizSessionCollectionViewCell: UICollectionViewCell {

    static let reuseIdentifier = String(describing: QuizSessionCollectionViewCell.self)

    private var questionLabel: UILabel!
    private var answersStack: UIStackView!

    weak var delegate: QuizSessionCollectionViewCellDelegate?

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
            answerView.delegate = self
            answersStack.addArrangedSubview(answerView)
        }
    }

}

extension QuizSessionCollectionViewCell: ConstructViewsProtocol {

    func createViews() {
        questionLabel = UILabel()
        contentView.addSubview(questionLabel)

        answersStack = UIStackView()
        contentView.addSubview(answersStack)
    }

    func styleViews() {
        questionLabel.textColor = .white
        questionLabel.font = .systemFont(ofSize: 24, weight: .bold)
        questionLabel.numberOfLines = 0

        answersStack.spacing = 16
        answersStack.axis = .vertical
    }

    func defineLayoutForViews() {
        questionLabel.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }

        answersStack.snp.makeConstraints {
            $0.top.equalTo(questionLabel.snp.bottom).offset(40).priority(.low)
            $0.trailing.leading.equalToSuperview()
            $0.bottom.lessThanOrEqualToSuperview()
        }
    }

}

extension QuizSessionCollectionViewCell: AnswerViewDelegate {

    func answerTapped(answerId: Int) {
        delegate?.answerTapped(answerId: answerId)
    }

}
