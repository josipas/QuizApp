import UIKit

class ProgressView: UIView {

    private var stackView: UIStackView!

    override init(frame: CGRect) {
        super.init(frame: .zero)

        createViews()
        styleViews()
        defineLayoutForViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(colors: [UIColor]) {
        stackView
            .arrangedSubviews
            .forEach { $0.removeFromSuperview() }

        for color in colors {
            let view = UIView()
            view.backgroundColor = color
            view.layer.cornerRadius = 2
            stackView.addArrangedSubview(view)
        }
    }

}

extension ProgressView: ConstructViewsProtocol {

    func createViews() {
        stackView = UIStackView()
        addSubview(stackView)
    }

    func styleViews() {
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.distribution = .fillEqually
    }

    func defineLayoutForViews() {
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalTo(5)
        }
    }

}
