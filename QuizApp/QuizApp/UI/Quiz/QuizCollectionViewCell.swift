import UIKit
import Kingfisher

class QuizCollectionViewCell: UICollectionViewCell {

    static let reuseIdentifier = String(describing: QuizCollectionViewCell.self)

    private var titleLabel: UILabel!
    private var textDescription: UILabel!
    private var imageView: UIImageView!
    private var difficultyView: QuizDifficultyLevelView!

    override init(frame: CGRect) {
        super.init(frame: .zero)

        createViews()
        styleViews()
        defineLayoutForViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(
        title: String,
        description: String,
        color: UIColor,
        difficulty: QuizDifficultyLevel,
        imageUrl: String
    ) {
        titleLabel.text = title
        textDescription.text = description
        imageView.kf.setImage(with: URL(string: imageUrl))
        difficultyView.set(color: color, difficulty: difficulty)
    }

}

extension QuizCollectionViewCell: ConstructViewsProtocol {

    func createViews() {
        titleLabel = UILabel()
        addSubview(titleLabel)

        textDescription = UILabel()
        addSubview(textDescription)

        imageView = UIImageView()
        addSubview(imageView)

        difficultyView = QuizDifficultyLevelView()
        addSubview(difficultyView)
    }

    func styleViews() {
        backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.3)
        layer.cornerRadius = 10

        titleLabel.font = .systemFont(ofSize: 24, weight: .bold)
        titleLabel.textColor = .white

        textDescription.numberOfLines = 0
        textDescription.textColor = .white
        textDescription.font = .systemFont(ofSize: 14)

        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
    }

    func defineLayoutForViews() {
        imageView.snp.makeConstraints {
            $0.width.height.equalTo(100)
            $0.top.leading.equalToSuperview().inset(20)
            $0.bottom.greaterThanOrEqualToSuperview().inset(20)
        }

        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(imageView.snp.trailing).offset(20)
            $0.trailing.equalToSuperview().inset(20)
            $0.top.equalToSuperview().inset(26)
            $0.bottom.equalTo(textDescription.snp.top).offset(-12)
        }

        textDescription.snp.makeConstraints {
            $0.leading.equalTo(imageView.snp.trailing).offset(20)
            $0.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(titleLabel.snp.bottom).offset(12)
            $0.bottom.equalToSuperview().inset(20)
        }

        difficultyView.snp.makeConstraints {
            $0.top.trailing.equalToSuperview().inset(15)
            $0.height.equalTo(10)
        }
    }

}
