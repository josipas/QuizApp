import UIKit
import SwiftUI

protocol AnswerViewDelegate: AnyObject {

    func answerTapped(answerId: Int)

}

class AnswerView: UIView {

    private var label: UILabel!
    private var answer: Answer!

    weak var delegate: AnswerViewDelegate!

    init(answer: Answer) {
        super.init(frame: .zero)

        self.answer = answer

        createViews()
        styleViews()
        defineLayoutForViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        layer.cornerRadius = bounds.height / 2
    }

    @objc private func answerTapped() {
        delegate.answerTapped(answerId: answer.id)
    }

}

extension AnswerView: ConstructViewsProtocol {

    func createViews() {
        label = UILabel()
        addSubview(label)
    }

    func styleViews() {
        label.numberOfLines = 0
        label.textColor = .white
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.text = answer.answer

        backgroundColor = answer.backgroundColor
        translatesAutoresizingMaskIntoConstraints = false

        let recognizer = UITapGestureRecognizer(target: self, action: #selector(answerTapped))
        addGestureRecognizer(recognizer)
    }

    func defineLayoutForViews() {
        snp.makeConstraints {
            $0.height.equalTo(60)
        }

        label.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(30)
        }
    }

}
