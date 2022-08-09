import Combine
import UIKit

class LeaderboardViewController: UIViewController {

    private let gradient = CAGradientLayer()

    private var viewModel: LeaderboardViewModel!
    private var titleLabel: UILabel!
    private var nameLabel: UILabel!
    private var pointsLabel: UILabel!
    private var separatorView: UIView!
    private var xButton: UIButton!
    private var tableView: UITableView!
    private var cancellables = Set<AnyCancellable>()
    private var leaderboard: [QuizLeaderboard] = []

    init(viewModel: LeaderboardViewModel) {
        super.init(nibName: nil, bundle: nil)

        self.viewModel = viewModel
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureGradient()
        createViews()
        styleViews()
        defineLayoutForViews()
        loadData()
        bindViewModel()
    }

    @objc func xButtonTapped() {
        viewModel.onXButtonTap()
    }

    private func configureGradient() {
        let startColor = UIColor(red: 0.453, green: 0.308, blue: 0.637, alpha: 1).cgColor
        let endColor = UIColor(red: 0.154, green: 0.185, blue: 0.463, alpha: 1).cgColor

        gradient.frame = view.bounds
        gradient.colors = [startColor, endColor]
        gradient.startPoint = CGPoint(x: 0.75, y: 0)
        gradient.endPoint = CGPoint(x: 0.25, y: 1)

        view.layer.insertSublayer(gradient, at: 0)
    }

    private func bindViewModel() {
        viewModel
            .$leaderboardList
            .sink { [weak self] leaderboardList in
                guard let self = self else { return }

                self.leaderboard = leaderboardList
                self.tableView.reloadData()
            }
            .store(in: &cancellables)
    }

    private func loadData() {
        viewModel.loadData()
    }

}

extension LeaderboardViewController: ConstructViewsProtocol {

    func createViews() {
        titleLabel = UILabel()
        view.addSubview(titleLabel)

        nameLabel = UILabel()
        view.addSubview(nameLabel)

        pointsLabel = UILabel()
        view.addSubview(pointsLabel)

        separatorView = UIView()
        view.addSubview(separatorView)

        xButton = UIButton()
        view.addSubview(xButton)

        tableView = UITableView()
        view.addSubview(tableView)
    }

    func styleViews() {
        isModalInPresentation = true

        titleLabel.text = "Leaderboard"
        titleLabel.font = .systemFont(ofSize: 24, weight: .bold)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center

        xButton.setImage(UIImage(named: "xButton"), for: .normal)
        xButton.addTarget(self, action: #selector(xButtonTapped), for: .touchUpInside)

        nameLabel.text = "Player"
        nameLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        nameLabel.textColor = .white

        pointsLabel.text = "Points"
        pointsLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        pointsLabel.textColor = .white
        pointsLabel.textAlignment = .right

        separatorView.backgroundColor = .white

        tableView.backgroundColor = .clear
        tableView.register(
            LeaderboardTableViewCell.self,
            forCellReuseIdentifier: LeaderboardTableViewCell.reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = .white
        tableView.separatorInset = .zero
        tableView.layoutMargins = .zero
    }

    func defineLayoutForViews() {
        titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(60)
            $0.trailing.equalTo(xButton.snp.leading).offset(-10)
        }

        xButton.snp.makeConstraints {
            $0.width.height.equalTo(26)
            $0.top.equalToSuperview().inset(60)
            $0.trailing.equalToSuperview().inset(25)
        }

        nameLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(50)
            $0.leading.equalToSuperview().inset(20)
        }

        pointsLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(50)
            $0.leading.equalTo(nameLabel.snp.trailing).offset(20)
            $0.trailing.equalToSuperview().inset(20)
        }

        separatorView.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1 / UIScreen.main.scale)
        }

        tableView.snp.makeConstraints {
            $0.top.equalTo(separatorView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(80)
        }
    }

}

extension LeaderboardViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        leaderboard.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView
                .dequeueReusableCell(
                    withIdentifier: LeaderboardTableViewCell.reuseIdentifier,
                    for: indexPath) as? LeaderboardTableViewCell
        else {
            fatalError()
        }

        cell.selectionStyle = .none
        cell.separatorInset = .zero
        cell.layoutMargins = .zero
        cell.set(
            rank: indexPath.row + 1,
            name: leaderboard[indexPath.row].name,
            points: leaderboard[indexPath.row].points)

        return cell
    }

}

extension LeaderboardViewController: UITableViewDelegate {

}
