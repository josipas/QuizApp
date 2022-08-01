import UIKit

class QuizCollectionViewFooter: UICollectionReusableView {

    static let reuseIdentifier = String(describing: QuizCollectionViewFooter.self)

    override init(frame: CGRect) {
        super.init(frame: .zero)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
