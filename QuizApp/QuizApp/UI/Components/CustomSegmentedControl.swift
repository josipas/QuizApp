import UIKit

protocol CustomSegmentedControlDelegate: AnyObject {
    func segmentTapped(view: SegmentView)
}

class CustomSegmentedControl: UIView {

    private var scrollView: UIScrollView!
    private var stackView: UIStackView!

    weak var delegate: CustomSegmentedControlDelegate!

    init() {
        super.init(frame: .zero)

        createViews()
        styleViews()
        defineLayoutForViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func loadData(data: [(String, UIColor)]) {
        for element in data {
            let segment = SegmentView(title: element.0, color: element.1)
            segment.delegate = self

            if stackView.arrangedSubviews.count == 0 {
                segment.reloadData(state: true)
            }

            stackView.addArrangedSubview(segment)
        }
    }

    func reloadData(view: SegmentView) {
        let views = stackView.arrangedSubviews
        view.reloadData(state: true)

        views.forEach { currentView in
            if currentView != view {
                let segment = currentView as? SegmentView
                segment?.reloadData(state: false)
            }
        }
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

extension CustomSegmentedControl: SegmentDelegate {

    func segmentTapped(view: SegmentView) {
        delegate.segmentTapped(view: view)
    }

}
