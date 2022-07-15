import UIKit
import SnapKit

class UserViewController: UIViewController {

    private let gradient = CAGradientLayer()

    private var viewModel: UserViewModel!
    private var stackView: UIStackView!
    private var usernameLabel: UILabel!
    private var usernameTextField: UITextField!
    private var logoutButton: UIButton!

    init(viewModel: UserViewModel) {
        super.init(nibName: nil, bundle: nil)

        self.viewModel = viewModel
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        createViews()
        styleViews()
        defineLayoutForViews()
        addActions()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        logoutButton.layer.cornerRadius = logoutButton.bounds.height / 2

        configureGradient()
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

    private func addActions() {
        logoutButton.addTarget(self, action: #selector(tappedLogoutButton), for: .touchUpInside)
    }

    @objc private func tappedLogoutButton() {
        viewModel.onButtonClick()
    }

}

extension UserViewController: ConstructViewsProtocol {

    func createViews() {
        stackView = UIStackView()
        view.addSubview(stackView)

        usernameLabel = UILabel()
        stackView.addArrangedSubview(usernameLabel)

        usernameTextField = UITextField()
        stackView.addArrangedSubview(usernameTextField)

        logoutButton = UIButton()
        view.addSubview(logoutButton)
    }

    func styleViews() {
        stackView.spacing = 10
        stackView.axis = .vertical

        usernameLabel.text = "USERNAME"
        usernameLabel.textColor = .white
        usernameLabel.font = .systemFont(ofSize: 12, weight: .bold)

        usernameTextField.font = .systemFont(ofSize: 20, weight: .bold)
        usernameTextField.textColor = .white
        usernameTextField.autocorrectionType = .no
        usernameTextField.autocapitalizationType = .none
        usernameTextField.placeholder = "Please enter your username"

        logoutButton.setTitle("Log out", for: .normal)
        logoutButton.setTitleColor(UIColor(red: 0.988, green: 0.395, blue: 0.395, alpha: 1), for: .normal)
        logoutButton.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        logoutButton.backgroundColor = .white
    }

    func defineLayoutForViews() {
        stackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalToSuperview().inset(110)
        }

        logoutButton.snp.makeConstraints {
            $0.trailing.leading.equalToSuperview().inset(32)
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-32)
            $0.height.equalTo(45)
        }
    }

}
