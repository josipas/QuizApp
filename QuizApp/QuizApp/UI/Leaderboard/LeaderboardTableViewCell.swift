import UIKit

class LeaderboardTableViewCell: UITableViewCell {

    static let reuseIdentifier = String(describing: LeaderboardTableViewCell.self)

    private var rankLabel: UILabel!
    private var nameLabel: UILabel!
    private var pointsLabel: UILabel!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        createViews()
        styleViews()
        defineLayoutForViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(rank: Int, name: String, points: Int) {
        rankLabel.text = "\(rank+1)."
        nameLabel.text = name
        pointsLabel.text = "\(points)"
    }

}

extension LeaderboardTableViewCell: ConstructViewsProtocol {

    func createViews() {
        rankLabel = UILabel()
        addSubview(rankLabel)

        nameLabel = UILabel()
        addSubview(nameLabel)

        pointsLabel = UILabel()
        addSubview(pointsLabel)
    }

    func styleViews() {
        backgroundColor = .clear

        rankLabel.font = .systemFont(ofSize: 20, weight: .bold)
        rankLabel.textColor = .white

        nameLabel.font = .systemFont(ofSize: 18)
        nameLabel.textColor = .white
        nameLabel.textAlignment = .left

        pointsLabel.font = .systemFont(ofSize: 26, weight: .bold)
        pointsLabel.textColor = .white
        pointsLabel.textAlignment = .right
    }

    func defineLayoutForViews() {
        rankLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
        }

        nameLabel.snp.makeConstraints {
            $0.leading.equalTo(rankLabel.snp.trailing).offset(10)
            $0.centerY.equalToSuperview()
        }

        pointsLabel.snp.makeConstraints {
            $0.leading.greaterThanOrEqualTo(nameLabel.snp.trailing).offset(10)
            $0.trailing.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
        }
    }

}
