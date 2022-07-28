import UIKit

protocol CustomSegmentedControlDelegate: AnyObject {

    func segmentTapped(id: Any)

}

struct CustomSegmentedControlModel {

    let id: Any
    let title: String
    let color: UIColor
    let isActive: Bool

}

class CustomSegmentedControl: UIView {

    private var scrollView: UIScrollView!
    private var stackView: UIStackView!

    weak var delegate: CustomSegmentedControlDelegate?

    init() {
        super.init(frame: .zero)

        createViews()
        styleViews()
        defineLayoutForViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(data: [CustomSegmentedControlModel]) {
        clear()

        for model in data {
            let label = makeLabel(model: model)

            stackView.addArrangedSubview(label)
        }
    }

    private func clear() {
        let views = stackView.arrangedSubviews

        for view in views {
            view.removeFromSuperview()
        }
    }

    private func makeLabel(model: CustomSegmentedControlModel) -> UILabel {
        let label = UILabel()

        label.text = model.title
        label.textColor = model.color
        label.isUserInteractionEnabled = true

        switch model.isActive {
        case true:
            label.font = .systemFont(ofSize: 20, weight: .bold)
        case false:
            label.font = .systemFont(ofSize: 20)
        }

        let recognizer = CustomTapGestureRecognizer(target: self, action: #selector(segmentTapped(sender:)))
        recognizer.id = model.id
        label.addGestureRecognizer(recognizer)

        return label
    }

    @objc private func segmentTapped(sender: CustomTapGestureRecognizer) {
        guard let id = sender.id else { return }

        delegate?.segmentTapped(id: id)
    }

}

private class CustomTapGestureRecognizer: UITapGestureRecognizer {

    var id: Any?

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
        scrollView.canCancelContentTouches = true
        scrollView.delaysContentTouches = true
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
