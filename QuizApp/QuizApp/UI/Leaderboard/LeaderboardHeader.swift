import UIKit
import SnapKit

class LeaderboardHeader: UITableViewHeaderFooterView {

    static let reuseIdentifier = String(describing: LeaderboardHeader.self)

    private var nameLabel: UILabel!
    private var pointsLabel: UILabel!

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)

        createViews()
        styleViews()
        defineLayoutForViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension LeaderboardHeader: ConstructViewsProtocol {

    func createViews() {
        nameLabel = UILabel()
        addSubview(nameLabel)

        pointsLabel = UILabel()
        addSubview(pointsLabel)
    }

    func styleViews() {
        nameLabel.text = "Player"
        nameLabel.font = .systemFont(ofSize: 16)
        nameLabel.textColor = .white

        pointsLabel.text = "Points"
        pointsLabel.font = .systemFont(ofSize: 16)
        pointsLabel.textColor = .white
    }

    func defineLayoutForViews() {
        nameLabel.snp.makeConstraints {
            $0.leading.bottom.equalToSuperview().inset(20)
        }

        pointsLabel.snp.makeConstraints {
            $0.trailing.bottom.equalToSuperview().inset(20)
        }
    }

}
