import UIKit
import SnapKit

class ErrorView: UIView {

    private var imageView: UIImageView!
    private var titleLabel: UILabel!
    private var descriptionLabel: UILabel!

    override init(frame: CGRect) {
        super.init(frame: .zero)

        createViews()
        styleViews()
        defineLayoutForViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension ErrorView: ConstructViewsProtocol {

    func createViews() {
        imageView = UIImageView(image: UIImage(systemName: "x.circle"))
        addSubview(imageView)

        titleLabel = UILabel()
        addSubview(titleLabel)

        descriptionLabel = UILabel()
        addSubview(descriptionLabel)
    }

    func styleViews() {
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFill

        titleLabel.text = "Error"
        titleLabel.textColor = .white
        titleLabel.font = .systemFont(ofSize: 28, weight: .bold)
        titleLabel.textAlignment = .center

        descriptionLabel.text = "Data can't be reached. Please try again."
        descriptionLabel.numberOfLines = 0
        descriptionLabel.textColor = .white
        descriptionLabel.textAlignment = .center
        descriptionLabel.font = .systemFont(ofSize: 16)
    }

    func defineLayoutForViews() {
        imageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.height.width.equalTo(70)
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview()
        }

        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }

}
