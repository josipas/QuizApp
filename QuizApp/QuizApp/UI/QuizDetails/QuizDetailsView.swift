import UIKit

protocol QuizDetailsViewDelegate: AnyObject {

    func startQuizButtonTapped()

}

class QuizDetailsView: UIView {

    private var titleLabel: UILabel!
    private var descriptionLabel: UILabel!
    private var imageView: UIImageView!
    private var startQuizButton: UIButton!
    private var quiz: Quiz!

    weak var delegate: QuizDetailsViewDelegate?

    init(quiz: Quiz) {
        super.init(frame: .zero)

        self.quiz = quiz
        createViews()
        styleViews()
        defineLayoutForViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        startQuizButton.layer.cornerRadius = startQuizButton.frame.height / 2
    }

    @objc func startQuizButtonTapped() {
        delegate?.startQuizButtonTapped()
    }
}

extension QuizDetailsView: ConstructViewsProtocol {

    func createViews() {
        titleLabel = UILabel()
        addSubview(titleLabel)

        descriptionLabel = UILabel()
        addSubview(descriptionLabel)

        imageView = UIImageView()
        addSubview(imageView)

        startQuizButton = UIButton()
        addSubview(startQuizButton)
    }

    func styleViews() {
        backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.3)
        layer.cornerRadius = 10

        titleLabel.text = quiz.name
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        titleLabel.font = .systemFont(ofSize: 32, weight: .bold)

        descriptionLabel.text = quiz.description
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textColor = .white
        descriptionLabel.textAlignment = .center
        descriptionLabel.font = .systemFont(ofSize: 18, weight: .bold)

        imageView.kf.setImage(with: URL(string: quiz.imageUrl))
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10

        startQuizButton.setTitle("Start Quiz", for: .normal)
        startQuizButton.setTitleColor(UIColor(red: 0.387, green: 0.16, blue: 0.871, alpha: 1), for: .normal)
        startQuizButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        startQuizButton.backgroundColor = .white
        startQuizButton.addTarget(self, action: #selector(startQuizButtonTapped), for: .touchUpInside)
    }

    func defineLayoutForViews() {
        titleLabel.snp.makeConstraints {
            $0.top.trailing.leading.equalToSuperview().inset(25)
        }

        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.trailing.leading.equalToSuperview().inset(35)
        }

        imageView.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(200)
        }

        startQuizButton.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(20)
            $0.leading.trailing.bottom.equalToSuperview().inset(20)
            $0.height.equalTo(45)
        }
    }

}
