import Combine
import UIKit

class LeaderboardViewController: UIViewController {

    private let gradient = CAGradientLayer()

    private var viewModel: LeaderboardViewModel!
    private var titleLabel: UILabel!
    private var xButton: UIButton!
    private var tableView: UITableView!
    private var headerView: LeaderboardHeader!
    private var cancellables = Set<AnyCancellable>()
    private var quizId: Int!
    private var leaderboard: [QuizLeaderboard] = []

    init(viewModel: LeaderboardViewModel, quizId: Int) {
        super.init(nibName: nil, bundle: nil)

        self.viewModel = viewModel
        self.quizId = quizId
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
        viewModel.loadData(quizId: quizId)
    }

}

extension LeaderboardViewController: ConstructViewsProtocol {

    func createViews() {
        titleLabel = UILabel()
        view.addSubview(titleLabel)

        xButton = UIButton()
        view.addSubview(xButton)

        tableView = UITableView(frame: .zero, style: .grouped)
        view.addSubview(tableView)

        headerView = LeaderboardHeader()
        view.addSubview(headerView)
    }

    func styleViews() {
        titleLabel.text = "Leaderboard"
        titleLabel.font = .systemFont(ofSize: 24, weight: .bold)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center

        xButton.setImage(UIImage(named: "xButton"), for: .normal)
        xButton.addTarget(self, action: #selector(xButtonTapped), for: .touchUpInside)

        tableView.backgroundColor = .clear
        tableView.register(
            LeaderboardTableViewCell.self,
            forCellReuseIdentifier: LeaderboardTableViewCell.reuseIdentifier)
        tableView.register(
            LeaderboardHeader.self,
            forHeaderFooterViewReuseIdentifier: LeaderboardHeader.reuseIdentifier)
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

        tableView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().inset(80)
        }
    }

}

extension LeaderboardViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard
            let cell = tableView
                .dequeueReusableHeaderFooterView(
                    withIdentifier: LeaderboardHeader.reuseIdentifier)
                as? LeaderboardHeader
        else {
            fatalError()
        }

        return cell
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        80
    }

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
        cell.set(rank: indexPath.row, name: leaderboard[indexPath.row].name, points: leaderboard[indexPath.row].points)

        return cell
    }

}

extension LeaderboardViewController: UITableViewDelegate {

}
