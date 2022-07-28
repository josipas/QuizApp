import UIKit

protocol SegmentDelegate: AnyObject {
    func segmentTapped(view: SegmentView)
}

class SegmentView: UIView {

    var title: String!
    private var color: UIColor!
    private var label: UILabel!

    weak var delegate: SegmentDelegate?

    init(title: String, color: UIColor) {
        super.init(frame: .zero)
        self.title = title
        self.color = color

        createViews()
        styleViews()
        defineLayoutForViews()
        addGesture()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func reloadData(state: Bool) {
        switch state {
        case true:
            label.font = .systemFont(ofSize: 20, weight: .bold)
        case false:
            label.font = .systemFont(ofSize: 20)
        }
    }

    private func addGesture() {
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        self.addGestureRecognizer(recognizer)
    }

    @objc private func viewTapped() {
        delegate?.segmentTapped(view: self)
    }

}

extension SegmentView: ConstructViewsProtocol {

    func createViews() {
        label = UILabel()
        addSubview(label)
    }

    func styleViews() {
        label.text = title
        label.font = .systemFont(ofSize: 20)
        label.textColor = color
    }

    func defineLayoutForViews() {
        label.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalToSuperview().inset(5)
        }
    }

}
