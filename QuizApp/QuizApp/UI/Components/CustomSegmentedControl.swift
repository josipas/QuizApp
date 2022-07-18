import UIKit

class CustomSegmentedControl: UIView {
    private var scrollView: UIScrollView!
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

}

extension CustomSegmentedControl: ConstructViewsProtocol {

    func createViews() {
        scrollView = UIScrollView()
        addSubview(scrollView)

        stackView = UIStackView()
        scrollView.addSubview(stackView)

    }

    func styleViews() {
        stackView.axis = .horizontal
        stackView.spacing = 22

        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
    }

    func defineLayoutForViews() {
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalToSuperview()
        }
    }

}
