import Combine
import UIKit

class QuizDetailsViewController: UIViewController {

    private let gradient = CAGradientLayer()

    private var viewModel: QuizDetailsViewModel!
    private var titleLabel: UILabel!
    private var backButtonImage: UIImage!
    private var leaderboardButton: UIButton!
    private var quizDetailsView: QuizDetailsView!
    private var cancellables = Set<AnyCancellable>()

    init(viewModel: QuizDetailsViewModel) {
        super.init(nibName: nil, bundle: nil)

        self.viewModel = viewModel
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpNavBar()
        createViews()
        styleViews()
        defineLayoutForViews()
        bindViewModel()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        configureGradient()
    }

    private func bindViewModel() {
        viewModel
            .$quiz
            .sink { [weak self] quiz in
                guard let self = self else { return }

                self.quizDetailsView.set(quiz: quiz)
            }
            .store(in: &cancellables)
    }

    private func setUpNavBar() {
        titleLabel = UILabel()
        titleLabel.text = "Pop Quiz"
        titleLabel.textColor = .white
        titleLabel.font = .systemFont(ofSize: 24, weight: .bold)
        navigationItem.titleView = titleLabel

        backButtonImage = UIImage(named: "backButton")
        let backItem = UIBarButtonItem(
            image: backButtonImage,
            style: .plain,
            target: self,
            action: #selector(backButtonTapped))
        navigationController?.navigationBar.tintColor = .white
        navigationItem.leftBarButtonItem = backItem
        navigationController?.isNavigationBarHidden = false
    }

    @objc func backButtonTapped() {
        viewModel.onBackButtonClick()
    }

    @objc func leaderboardButtonTapped() {
        viewModel.onLeaderboardButtonClick()
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

}

extension QuizDetailsViewController: ConstructViewsProtocol {

    func createViews() {
        leaderboardButton = UIButton()
        view.addSubview(leaderboardButton)

        quizDetailsView = QuizDetailsView()
        view.addSubview(quizDetailsView)
    }

    func styleViews() {
        let attributes: [NSAttributedString.Key: Any] = [
            .underlineStyle: NSUnderlineStyle.thick.rawValue,
            .foregroundColor: UIColor.white,
            .font: UIFont.systemFont(ofSize: 18, weight: .bold)]
        let underlineAttributedString = NSAttributedString(string: "Leaderboard", attributes: attributes)

        leaderboardButton.setAttributedTitle(underlineAttributedString, for: .normal)
        leaderboardButton.addTarget(self, action: #selector(leaderboardButtonTapped), for: .touchUpInside)

        quizDetailsView.delegate = self
    }

    func defineLayoutForViews() {
        leaderboardButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).inset(70)
            $0.trailing.equalToSuperview().inset(20)
        }

        quizDetailsView.snp.makeConstraints {
            $0.top.equalTo(leaderboardButton.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
    }

}

extension QuizDetailsViewController: QuizDetailsViewDelegate {

    func startQuizButtonTapped() {
        viewModel.onStartQuizButtonClick()
    }

}
